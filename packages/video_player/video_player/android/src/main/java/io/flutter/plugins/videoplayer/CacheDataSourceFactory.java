package io.flutter.plugins.videoplayer;

import android.content.Context;

import com.google.android.exoplayer2.database.DatabaseProvider;
import com.google.android.exoplayer2.database.ExoDatabaseProvider;
import com.google.android.exoplayer2.upstream.DataSource;
import com.google.android.exoplayer2.upstream.FileDataSource;
import com.google.android.exoplayer2.upstream.cache.Cache;
import com.google.android.exoplayer2.upstream.cache.CacheDataSink;
import com.google.android.exoplayer2.upstream.cache.CacheDataSource;
import com.google.android.exoplayer2.upstream.cache.LeastRecentlyUsedCacheEvictor;
import com.google.android.exoplayer2.upstream.cache.SimpleCache;

import java.io.File;

class CacheDataSourceFactory implements DataSource.Factory {
    private static final String DOWNLOAD_CONTENT_DIRECTORY = "media";
    private static final int MAX_CACHE_SIZE = 150 * 1024 * 1024;
    private static final int MAX_CACHE_FILE_SIZE = 15 * 1024 * 1024;
    private static Cache downloadCache;
    private static DatabaseProvider databaseProvider;
    private final Context context;
    private DataSource.Factory upstreamFactory;

    CacheDataSourceFactory(Context context, DataSource.Factory upstreamFactory) {
        super();
        this.context = context;
        this.upstreamFactory = upstreamFactory;
    }

    public static synchronized Cache getDownloadCache(Context context) {
        if (downloadCache == null) {
            LeastRecentlyUsedCacheEvictor evictor = new LeastRecentlyUsedCacheEvictor(MAX_CACHE_SIZE);
            File downloadContentDirectory = new File(context.getCacheDir(), DOWNLOAD_CONTENT_DIRECTORY);
            downloadCache =
                    new SimpleCache(downloadContentDirectory, evictor, getDatabaseProvider(context));
        }
        return downloadCache;
    }

    private static DatabaseProvider getDatabaseProvider(Context context) {
        if (databaseProvider == null) {
            databaseProvider = new ExoDatabaseProvider(context);
        }
        return databaseProvider;
    }

    @Override
    public DataSource createDataSource() {
        return new CacheDataSource(getDownloadCache(context), upstreamFactory.createDataSource(),
                new FileDataSource(), new CacheDataSink(getDownloadCache(context), MAX_CACHE_FILE_SIZE),
                CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR, null);
    }
}