//
//  RSPreviewLayer.m
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSPreviewLayer.h"

@implementation RSPreviewLayer

- (instancetype)initWithSession:(AVCaptureSession *)session frame:(CGRect)frame {
    self = [super initWithSession:session];
    
    if (self) {
        self.session = session;
        self.frame = frame;
        self.transform = CATransform3DScale(CATransform3DMakeRotation(M_PI, 0, 1, 0),1, 1, 1);
        self.isMirrored = NO;
    }
    return self;
}

- (void)changeOrientationTo:(UIInterfaceOrientation)orientation {
    AVCaptureVideoOrientation newOrientation;
    
    switch (orientation) { //inline simple switch cases improves readability
        case UIInterfaceOrientationPortrait: newOrientation = AVCaptureVideoOrientationPortrait; break;
        case UIInterfaceOrientationPortraitUpsideDown: newOrientation = AVCaptureVideoOrientationPortraitUpsideDown; break;
        case UIInterfaceOrientationLandscapeRight: newOrientation = AVCaptureVideoOrientationLandscapeRight; break;
        case UIInterfaceOrientationLandscapeLeft: newOrientation = AVCaptureVideoOrientationLandscapeLeft; break;
        default: newOrientation = AVCaptureVideoOrientationPortrait;
    }
    
    if ([self.connection isVideoOrientationSupported]) {
        self.connection.videoOrientation = newOrientation;
    }
}

#pragma mark - Layer Mirroring

/**
 *  @author Roger Oba
 *
 *  Mirrors the preview layer.
 */
- (void)mirrorLayer {
    if (self.isMirrored) {
        [self displayWorldVision];
    } else {
        [self displayMirrorVision];
    }
}

/**
 *  @author Roger Oba
 *
 *  Transforms the layer view to World Vision.
 */
- (void)displayWorldVision {
    self.isMirrored = NO;
    self.transform = CATransform3DScale(CATransform3DMakeRotation(M_PI, 0, 1, 0), 1, 1, 1);
    self.cameraStatus = NSLocalizedString(@"How The World Sees You", @"Camera Status: Real");
}


/**
 *  @author Roger Oba
 *
 *  Transforms the layer view to Mirror Vision.
 */
- (void)displayMirrorVision {
    self.isMirrored = YES;
    self.transform = CATransform3DScale(CATransform3DMakeRotation(2*M_PI, 0, 1, 0), 1, 1, 1);
    self.cameraStatus = NSLocalizedString(@"How You See Yourself In The Mirror", @"Camera Status: Mirrored");
}


@end
