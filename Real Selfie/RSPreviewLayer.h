//
//  RSPreviewLayer.h
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface RSPreviewLayer : AVCaptureVideoPreviewLayer

@property (assign,nonatomic) BOOL isMirrored;
@property (strong,nonatomic) NSString *cameraStatus;

- (instancetype)initWithSession:(AVCaptureSession *)session frame:(CGRect)frame;
- (void)mirrorLayer;
- (void)changeOrientationTo:(UIInterfaceOrientation)orientation;

//These are not being used publicly but they might be used later.
- (void)displayWorldVision;
- (void)displayMirrorVision;

@end