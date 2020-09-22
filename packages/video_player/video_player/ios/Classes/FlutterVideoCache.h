//
//  VideoCache.h
//  Pods
//
//  Created by Onyemaechi Okafor on 5/13/19.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SPTPersistentCache/SPTPersistentCache.h>
#import <SPTPersistentCache/SPTPersistentCacheOptions.h>
#import <CommonCrypto/CommonDigest.h>

typedef NS_ENUM(NSUInteger, FlutterVideoCacheStatus) {
    FlutterVideoCacheStatusMissingFileExtension,
    FlutterVideoCacheStatusUnsupportedFileExtension,
    FlutterVideoCacheStatusNotAvailable,
    FlutterVideoCacheStatusAvailable
};

@class SPTPersistentCache;
@class SPTPersistentCacheOptions;

@interface FlutterVideoCache : NSObject
{
    SPTPersistentCache *videoCache;
    NSString * _Nullable cachePath;
    NSString * temporaryCachePath;
    NSString * _Nullable cacheIdentifier;
}

@property(nonatomic, strong) SPTPersistentCache * _Nullable videoCache;
@property(nonatomic, strong) NSString * cachePath;
@property(nonatomic, strong) NSString * cacheIdentifier;
@property(nonatomic, strong) NSString * temporaryCachePath;

+ (FlutterVideoCache *)sharedInstance;
- (void)storeItem:(NSData *)data forUri:(NSString *)uri withCallback:(void(^)(BOOL))handler;
- (void)getItemForUri:(NSString *)url withCallback:(void(^)(FlutterVideoCacheStatus, AVAsset * _Nullable)) handler;
- (NSURL *)createUniqueTemporaryFileUrl:(NSString * _Nonnull)url withExtension:(NSString * _Nonnull) extension;
- (AVURLAsset *)getItemFromTemporaryStorage:(NSString *)key;
- (BOOL)saveDataToTemporaryStorage:(NSData *)data key:(NSString *)key;
- (void) createTemporaryPath;

@end
