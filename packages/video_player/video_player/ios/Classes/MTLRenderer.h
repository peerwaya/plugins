/*
 *  Copyright 2017 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#define MTL_STRINGIFY(s) @ #s

NS_ASSUME_NONNULL_BEGIN
/**
 * Protocol defining ability to render RTCVideoFrame in Metal enabled views.
 */
@protocol MTLRenderer <NSObject>

/**
 * Method to be implemented to perform actual rendering of the provided frame.
 *
 * @param frame The frame to be rendered.
 */
- (void)drawFrame:(CVPixelBufferRef)frame withRotation:(int)rotation inTexture:(id<MTLTexture>)texture;


@end

/**
 * Implementation of RTCMTLRenderer protocol.
 */
NS_AVAILABLE(10_11, 9_0)
@interface FlutterMTLRenderer : NSObject <MTLRenderer>

/** @abstract   A wrapped RTCVideoRotation, or nil.
    @discussion When not nil, the rotation of the actual frame is ignored when rendering.
 */
@property(atomic, nullable) NSValue *rotationOverride;
- (instancetype)initWithDevice:(id<MTLDevice>)device;
- (nullable id<MTLDevice>)currentMetalDevice;
- (NSString *)shaderSource;
- (BOOL)setupTexturesForFrame:(nonnull CVPixelBufferRef)frame rotation:(int)rotation;
- (void)uploadTexturesToRenderEncoder:(id<MTLRenderCommandEncoder>)renderEncoder;
- (void)getWidth:(int *)width
          height:(int *)height
         ofFrame:(nonnull CVPixelBufferRef)frame
        rotation:(int)rotation;
@end

NS_ASSUME_NONNULL_END
