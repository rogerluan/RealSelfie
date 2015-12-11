//
//  RSCameraManager.m
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSCameraManager.h"
#import "UIImage+Orientation.h"

@interface RSCameraManager();

@property (strong,nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong,nonatomic,readwrite) AVCaptureSession *session;

@end

@implementation RSCameraManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageOutput = [self setupImageOutput];
        AVCaptureDeviceInput *deviceInput = [self setupDeviceInput];
        self.session = [self setupSessionWithImageOutput:self.imageOutput];
        if([self.session canAddInput:deviceInput]) {
           [self.session addInput:deviceInput];
        } else {
            NSLog(@"Error when adding deviceInput to session");
        }
    }
    return self;
}

- (void)captureSelfie:(didTakeSelfie)completion {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.imageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        if (imageData) {
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            completion(image,nil);
        } else {
            NSLog(@"Failed to save screenshot.");
            completion(nil,error);
        }
    }];

}

/**
 *  @author Roger Oba
 *
 *  Starts running the camera.
 */
- (BOOL)startRunningCamera {
    if (self.session) {
        [self.session startRunning];
		return YES;
    } else {
		NSLog(@"Couldn't start running the session because the session is not valid.");
		return NO;
	}
}

#pragma mark - Setup

#pragma mark - Session


/**
 *  @author Roger Oba
 *
 *  Configures and returns the capture session with the given image output.
 *
 *  @param imageOutput The image output used to create the capture session.
 *
 *  @return Returns the capture session created.
 */
- (AVCaptureSession*)setupSessionWithImageOutput:(AVCaptureStillImageOutput*)imageOutput {
    AVCaptureSession *session = [AVCaptureSession new];
    session.sessionPreset = AVCaptureSessionPresetHigh;
    
    [session addOutput:imageOutput];
    
    return session;
}

#pragma mark - Image Output


/**
 *  @author Roger Oba
 *
 *  Configures and returns the device still image output.
 *
 *  @return Returns the device still image output.
 */
- (AVCaptureStillImageOutput*)setupImageOutput {
    AVCaptureStillImageOutput *imageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [imageOutput setOutputSettings:outputSettings];
    return imageOutput;
}

#pragma mark - Device Input

/**
 *  @author Roger Oba
 *
 *  Configures and returns the front cam device input.
 *
 *  @return Returns the front cam device input.
 */
- (AVCaptureDeviceInput*)setupDeviceInput {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        }
    }
    return nil;
}

@end
