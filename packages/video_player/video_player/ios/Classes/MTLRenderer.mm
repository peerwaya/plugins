/*
 *  Copyright 2017 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import "MTLRenderer.h"

// As defined in shaderSource.
static NSString *const vertexFunctionName = @"vertexPassthrough";
static NSString *const fragmentFunctionName = @"fragmentColorConversion";

static NSString *const pipelineDescriptorLabel = @"RTCPipeline";
static NSString *const commandBufferLabel = @"RTCCommandBuffer";
static NSString *const renderEncoderLabel = @"RTCEncoder";
static NSString *const renderEncoderDebugGroup = @"RTCDrawFrame";

// Computes the texture coordinates given rotation and cropping.
static inline void getCubeVertexData(size_t frameWidth,
                                     size_t frameHeight,
                                     int rotation,
                                     float *buffer) {
  // These arrays map the view coordinates to texture coordinates, taking cropping and rotation
  // into account. The first two columns are view coordinates, the last two are texture coordinates.
  switch (rotation) {
    case 0: {
      float values[16] = {-1.0, -1.0, 0.0, 1.0,
                           1.0, -1.0, 1.0, 1.0,
                          -1.0,  1.0, 0.0, 0.0,
                           1.0,  1.0, 1.0, 0.0};
      memcpy(buffer, &values, sizeof(values));
    } break;
    case 90: {
      float values[16] = {-1.0, -1.0, 1.0, 1.0,
                           1.0, -1.0, 1.0, 0.0,
                          -1.0,  1.0, 0.0, 1.0,
                           1.0,  1.0, 0.0, 0.0};
      memcpy(buffer, &values, sizeof(values));
    } break;
    case 180: {
      float values[16] = {-1.0, -1.0, 1.0, 0.0,
                           1.0, -1.0, 0.0, 0.0,
                          -1.0,  1.0, 1.0, 1.0,
                           1.0,  1.0, 0.0, 1.0};
      memcpy(buffer, &values, sizeof(values));
    } break;
    case 270: {
      float values[16] = {-1.0, -1.0, 0.0, 0.0,
                           1.0, -1.0, 0.0, 1.0,
                          -1.0, 1.0, 1.0, 0.0,
                           1.0, 1.0, 1.0, 1.0};
      memcpy(buffer, &values, sizeof(values));
    } break;
  }
}

// The max number of command buffers in flight (submitted to GPU).
// For now setting it up to 1.
// In future we might use triple buffering method if it improves performance.
static const NSInteger kMaxInflightBuffers = 1;

@implementation FlutterMTLRenderer {

  // Controller.
  dispatch_semaphore_t _inflight_semaphore;

  // Renderer.
  id<MTLDevice> _device;
  id<MTLCommandQueue> _commandQueue;
  id<MTLLibrary> _defaultLibrary;
  id<MTLRenderPipelineState> _pipelineState;
  
  // Buffers.
  id<MTLBuffer> _vertexBuffer;
  // Values affecting the vertex buffer. Stored for comparison to avoid unnecessary recreation.
  int _oldFrameWidth;
  int _oldFrameHeight;
  int _oldRotation;
  id<MTLTexture> _texture;
  MTLRenderPassDescriptor *_renderPassDescriptor;
}

@synthesize rotationOverride = _rotationOverride;

- (instancetype)initWithDevice:(id<MTLDevice>)device{
  if (self = [super init]) {
     _device = device;
    _inflight_semaphore = dispatch_semaphore_create(kMaxInflightBuffers);
     [self setupMetal];
  }

  return self;
}


#pragma mark - Inheritance

- (id<MTLDevice>)currentMetalDevice {
  return _device;
}

- (NSString *)shaderSource {
  return nil;
}

- (void)uploadTexturesToRenderEncoder:(id<MTLRenderCommandEncoder>)renderEncoder {
}

- (void)getWidth:(int *)width
          height:(int *)height
         ofFrame:(nonnull CVPixelBufferRef)frame
        rotation:(int)rotation {
}

- (BOOL)setupTexturesForFrame:(nonnull CVPixelBufferRef)frame rotation:(int)rotation{
  // Apply rotation override if set.
  int rotationValue;
  NSValue *rotationOverride = self.rotationOverride;
  if (rotationOverride) {
#if defined(__IPHONE_11_0) && defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && \
    (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
    if (@available(iOS 11, *)) {
      [rotationOverride getValue:&rotationValue size:sizeof(rotationValue)];
    } else
#endif
    {
      [rotationOverride getValue:&rotationValue];
    }
  } else {
    rotationValue = rotation;
  }

  int frameWidth, frameHeight;
  [self getWidth:&frameWidth
          height:&frameHeight
         ofFrame:frame
        rotation:rotationValue
   ];

  // Recompute the texture cropping and recreate vertexBuffer if necessary.
  if (rotationValue != _oldRotation || frameWidth != _oldFrameWidth ||
      frameHeight != _oldFrameHeight) {
    getCubeVertexData(frameWidth,
                      frameHeight,
                      rotationValue,
                      (float *)_vertexBuffer.contents);
    _oldFrameWidth = frameWidth;
    _oldFrameHeight = frameHeight;
    _oldRotation = rotationValue;
  }

  return YES;
}

#pragma mark - GPU methods

- (BOOL)setupMetal {

  // Create a new command queue.
  _commandQueue = [_device newCommandQueue];

  // Load metal library from source.
  NSError *libraryError = nil;
  NSString *shaderSource = [self shaderSource];

  id<MTLLibrary> sourceLibrary =
      [_device newLibraryWithSource:shaderSource options:NULL error:&libraryError];

  if (libraryError) {
    NSLog(@"Metal: Library with source failed\n%@", libraryError);
    return NO;
  }

  if (!sourceLibrary) {
    NSLog(@"Metal: Failed to load library. %@", libraryError);
    return NO;
  }
  _defaultLibrary = sourceLibrary;

  [self loadAssets];

  float vertexBufferArray[16] = {0};
  _vertexBuffer = [_device newBufferWithBytes:vertexBufferArray
                                         length:sizeof(vertexBufferArray)
                                        options:MTLResourceCPUCacheModeWriteCombined];
  _renderPassDescriptor = [MTLRenderPassDescriptor new];
  _renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 1);
  _renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
  _renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
  return YES;
}

- (void)loadAssets {
  id<MTLFunction> vertexFunction = [_defaultLibrary newFunctionWithName:vertexFunctionName];
  id<MTLFunction> fragmentFunction = [_defaultLibrary newFunctionWithName:fragmentFunctionName];

  MTLRenderPipelineDescriptor *pipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
  pipelineDescriptor.label = pipelineDescriptorLabel;
  pipelineDescriptor.vertexFunction = vertexFunction;
  pipelineDescriptor.fragmentFunction = fragmentFunction;
  pipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
  pipelineDescriptor.depthAttachmentPixelFormat = MTLPixelFormatInvalid;
  NSError *error = nil;
  _pipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineDescriptor error:&error];

  if (!_pipelineState) {
    NSLog(@"Metal: Failed to create pipeline state. %@", error);
  }
}

- (void)renderInTexture:(id<MTLTexture>)texture {
  id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
  commandBuffer.label = commandBufferLabel;

  __block dispatch_semaphore_t block_semaphore = _inflight_semaphore;
  [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> _Nonnull) {
    // GPU work completed.
    dispatch_semaphore_signal(block_semaphore);
  }];

  if (_renderPassDescriptor) {
      _renderPassDescriptor.colorAttachments[0].texture = texture;// Valid drawable
    id<MTLRenderCommandEncoder> renderEncoder =
        [commandBuffer renderCommandEncoderWithDescriptor:_renderPassDescriptor];
    renderEncoder.label = renderEncoderLabel;

    // Set context state.
    [renderEncoder pushDebugGroup:renderEncoderDebugGroup];
    [renderEncoder setRenderPipelineState:_pipelineState];
    [renderEncoder setVertexBuffer:_vertexBuffer offset:0 atIndex:0];
    [self uploadTexturesToRenderEncoder:renderEncoder];

    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangleStrip
                      vertexStart:0
                      vertexCount:4
                    instanceCount:1];
    [renderEncoder popDebugGroup];
    [renderEncoder endEncoding];

  }

  // CPU work is completed, GPU work can be started.
  [commandBuffer commit];
}

#pragma mark - RTCMTLRenderer

- (void)drawFrame:(CVPixelBufferRef)frame withRotation:(int)rotation inTexture:(id<MTLTexture>)texture{
  @autoreleasepool {
    // Wait until the inflight (curently sent to GPU) command buffer
    // has completed the GPU work.
    dispatch_semaphore_wait(_inflight_semaphore, DISPATCH_TIME_FOREVER);

    if ([self setupTexturesForFrame:frame rotation:rotation]) {
      [self renderInTexture:texture];
    } else {
      dispatch_semaphore_signal(_inflight_semaphore);
    }
  }
}

@end
