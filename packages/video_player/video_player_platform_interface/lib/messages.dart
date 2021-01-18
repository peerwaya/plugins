// Autogenerated from Pigeon (v0.1.12), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import
// @dart = 2.12
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

class TextureMessage {
  int? textureId;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['textureId'] = textureId;
    return pigeonMap;
  }

  // ignore: unused_element
  static TextureMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final TextureMessage result = TextureMessage();
    result.textureId = pigeonMap['textureId'];
    return result;
  }
}

class CreateMessage {
  String? asset;
  String? uri;
  String? packageName;
  String? formatHint;
  bool? cacheEnabled;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['asset'] = asset;
    pigeonMap['uri'] = uri;
    pigeonMap['packageName'] = packageName;
    pigeonMap['formatHint'] = formatHint;
    pigeonMap['cacheEnabled'] = cacheEnabled;
    return pigeonMap;
  }

  // ignore: unused_element
  static CreateMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final CreateMessage result = CreateMessage();
    result.asset = pigeonMap['asset'];
    result.uri = pigeonMap['uri'];
    result.packageName = pigeonMap['packageName'];
    result.formatHint = pigeonMap['formatHint'];
    result.cacheEnabled = pigeonMap['cacheEnabled'];
    return result;
  }
}

class LoopingMessage {
  int? textureId;
  bool? isLooping;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['isLooping'] = isLooping;
    return pigeonMap;
  }

  // ignore: unused_element
  static LoopingMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final LoopingMessage result = LoopingMessage();
    result.textureId = pigeonMap['textureId'];
    result.isLooping = pigeonMap['isLooping'];
    return result;
  }
}

class VolumeMessage {
  int? textureId;
  double? volume;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['volume'] = volume;
    return pigeonMap;
  }

  // ignore: unused_element
  static VolumeMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final VolumeMessage result = VolumeMessage();
    result.textureId = pigeonMap['textureId'];
    result.volume = pigeonMap['volume'];
    return result;
  }
}

class MutedMessage {
  int? textureId;
  bool? muted;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['muted'] = muted;
    return pigeonMap;
  }

  // ignore: unused_element
  static MutedMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final MutedMessage result = MutedMessage();
    result.textureId = pigeonMap['textureId'];
    result.muted = pigeonMap['muted'];
    return result;
  }
}

class PlaybackSpeedMessage {
  int? textureId;
  double? speed;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['speed'] = speed;
    return pigeonMap;
  }

  // ignore: unused_element
  static PlaybackSpeedMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final PlaybackSpeedMessage result = PlaybackSpeedMessage();
    result.textureId = pigeonMap['textureId'];
    result.speed = pigeonMap['speed'];
    return result;
  }
}

class PositionMessage {
  int? textureId;
  int? position;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['position'] = position;
    return pigeonMap;
  }

  // ignore: unused_element
  static PositionMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final PositionMessage result = PositionMessage();
    result.textureId = pigeonMap['textureId'];
    result.position = pigeonMap['position'];
    return result;
  }
}

class MixWithOthersMessage {
  bool? mixWithOthers;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['mixWithOthers'] = mixWithOthers;
    return pigeonMap;
  }

  // ignore: unused_element
  static MixWithOthersMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final MixWithOthersMessage result = MixWithOthersMessage();
    result.mixWithOthers = pigeonMap['mixWithOthers'];
    return result;
  }
}

class VideoPlayerApi {
  Future<void> initialize() async {
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.initialize', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(null);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<TextureMessage> create(CreateMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.create', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      return TextureMessage._fromMap(replyMap['result']);
    }
  }

  Future<void> dispose(TextureMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.dispose', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> setLooping(LoopingMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.setLooping', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> setVolume(VolumeMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.setVolume', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> setMuted(MutedMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.setMuted', StandardMessageCodec());

    final Map<dynamic, dynamic> replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> setPlaybackSpeed(PlaybackSpeedMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.setPlaybackSpeed',
        StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> play(TextureMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.play', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<PositionMessage> position(TextureMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.position', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      return PositionMessage._fromMap(replyMap['result']);
    }
  }

  Future<void> seekTo(PositionMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.seekTo', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> pause(TextureMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.pause', StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }

  Future<void> setMixWithOthers(MixWithOthersMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
        'dev.flutter.pigeon.VideoPlayerApi.setMixWithOthers',
        StandardMessageCodec());

    final Map<dynamic, dynamic>? replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
          code: 'channel-error',
          message: 'Unable to establish connection on channel.',
          details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
  }
}

abstract class TestHostVideoPlayerApi {
  void initialize();
  TextureMessage create(CreateMessage arg);
  void dispose(TextureMessage arg);
  void setLooping(LoopingMessage arg);
  void setVolume(VolumeMessage arg);
  void setMuted(MutedMessage arg);
  void setPlaybackSpeed(PlaybackSpeedMessage arg);
  void play(TextureMessage arg);
  PositionMessage position(TextureMessage arg);
  void seekTo(PositionMessage arg);
  void pause(TextureMessage arg);
  void setMixWithOthers(MixWithOthersMessage arg);
  static void setup(TestHostVideoPlayerApi? api) {
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.initialize',
          StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          api.initialize();
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.create', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final CreateMessage input = CreateMessage._fromMap(mapMessage);
          final TextureMessage output = api.create(input);
          return <dynamic, dynamic>{'result': output._toMap()};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.dispose', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final TextureMessage input = TextureMessage._fromMap(mapMessage);
          api.dispose(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.setLooping',
          StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final LoopingMessage input = LoopingMessage._fromMap(mapMessage);
          api.setLooping(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.setVolume',
          StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final VolumeMessage input = VolumeMessage._fromMap(mapMessage);
          api.setVolume(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.setMuted', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final MutedMessage input = MutedMessage._fromMap(mapMessage);
          api.setMuted(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.setPlaybackSpeed',
          StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final PlaybackSpeedMessage input =
              PlaybackSpeedMessage._fromMap(mapMessage);
          api.setPlaybackSpeed(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.play', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final TextureMessage input = TextureMessage._fromMap(mapMessage);
          api.play(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.position', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final TextureMessage input = TextureMessage._fromMap(mapMessage);
          final PositionMessage output = api.position(input);
          return <dynamic, dynamic>{'result': output._toMap()};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.seekTo', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final PositionMessage input = PositionMessage._fromMap(mapMessage);
          api.seekTo(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.pause', StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final TextureMessage input = TextureMessage._fromMap(mapMessage);
          api.pause(input);
          return <dynamic, dynamic>{};
        });
      }
    }
    {
      const BasicMessageChannel<dynamic> channel = BasicMessageChannel<dynamic>(
          'dev.flutter.pigeon.VideoPlayerApi.setMixWithOthers',
          StandardMessageCodec());
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((dynamic message) async {
          final Map<dynamic, dynamic> mapMessage =
              message as Map<dynamic, dynamic>;
          final MixWithOthersMessage input =
              MixWithOthersMessage._fromMap(mapMessage);
          api.setMixWithOthers(input);
          return <dynamic, dynamic>{};
        });
      }
    }
  }
}
