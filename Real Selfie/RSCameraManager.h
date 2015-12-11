//
//  RSCameraManager.h
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RSCompletionBlocks.h"

@interface RSCameraManager : NSObject

@property (strong,nonatomic,readonly) AVCaptureSession *session;

- (void)captureSelfie:(didTakeSelfie)completion;
- (BOOL)startRunningCamera;

@end
