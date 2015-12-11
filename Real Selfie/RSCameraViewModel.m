//
//  RSCameraViewModel.m
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSCameraViewModel.h"
#import "RSCameraManager.h"
#import "RSStoreManager.h"
#import "RSTutorialView.h"
#import "UIImage+Orientation.h"
#import "RSDeviceOrientationManager.h"

@interface RSCameraViewModel();

@property (strong,nonatomic) RSCameraManager *cameraManager;
@property (strong,nonatomic) RSStoreManager *storeManager;
@property (strong,nonatomic) RSTutorialView *tutorialView;
@property (strong,nonatomic) RSDeviceOrientationManager *deviceOrientationManager;

@end

@implementation RSCameraViewModel

- (instancetype)initWithCamera:(RSCameraManager *)cameraManager storeManager:(RSStoreManager *)storeManager deviceOrientationManager:(RSDeviceOrientationManager *)deviceOrientationManager {
    if (!(self = [super init])) return nil; //if can't init, quit.
    
    self.cameraManager = cameraManager;
	self.storeManager = storeManager;
    self.deviceOrientationManager = deviceOrientationManager;
    
    return self;
}

#pragma mark - Camera -

- (void)takeSelfie {
    [self.cameraManager captureSelfie:^(UIImage *selfie, NSError *error) {
        if (!error) {
            [self sendSelfie:selfie];
        } else {
            [self sendError:error];
        }
    }];
}

- (BOOL)startRunningCamera {
    if (self.cameraManager) {
        return [self.cameraManager startRunningCamera];
    } else {
		NSLog(@"Failed with error: %@",[RSErrorManager errorForErrorIdentifier:RS_CAMERA_INIT_ERROR].localizedDescription);
		return NO;
    }
}

- (void)saveSelfie:(UIImage*)selfie mirrored:(BOOL)mirrored withSuccess:(operationSucceed)succeed failure:(operationFailed)failure{
	if (selfie) {
        UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
        NSDictionary *settingsDictionary = @{@"imageOrientation":[NSNumber numberWithInteger:interfaceOrientation],@"mirrored":[NSNumber numberWithBool:mirrored]};
        
        [self.storeManager savePhoto:selfie photoSettings:settingsDictionary toDocumentsDirectoryWithSuccess:^{
            succeed();
        } orError:^(NSError *error) {
            failure(error);
        }];
        
        selfie = [selfie rotateWithSettings:settingsDictionary];
        
		[self.storeManager savePhoto:selfie toCameraRollWithSuccess:^{
			succeed();
		} orError:^(NSError *error) {
			failure(error);
		}];
	} else {
		failure([RSErrorManager errorForErrorIdentifier:RS_INVALID_PARAMETER]);
	}
}

- (AVCaptureSession*)cameraManagerSession {
    return [self.cameraManager session];
}

#pragma mark - Device Orientation - 

- (void)updateDeviceOrientationWithAcceleration:(UIAcceleration *)acceleration {
    [self.deviceOrientationManager updateDeviceOrientationWithAcceleration:acceleration];
}

#pragma mark - Tutorial -

- (void)displayTutorialIfNeededIn:(id)sender animated:(BOOL)animated completion:(tutorialAppearIfNeededBlock)completion{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"returningUser"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"returningUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //It's the first time the user opens this app
        
        [self displayTutorialIn:sender animated:animated completion:^{
            completion(YES);
        }];
    } else {
        completion(NO);
        NSLog(@"User has already seen this tutorial.");
    }
}

- (void)displayTutorialIn:(id)sender animated:(BOOL)animated completion:(tutorialDidAppearBlock)completion {
    self.tutorialView = [RSTutorialView new];
    self.tutorialView.delegate = sender;
    self.tutorialView.animated = animated;
    [self.tutorialView displayTutorialIn:sender completion:^{
        completion();
    }];
}

- (void)updateTutorialConstraints {
    [self.tutorialView updateVisualEffectViewConstraints];
}

#pragma mark - Block Data Refresh -

/**
 *  @author Roger Oba
 *
 *  Notifies the View Controller when the selfie is captured.
 *
 *  @param selfie UIImage instance that represents a Selfie.
 */
- (void)sendSelfie:(UIImage*)selfie {
    if (self.didCaptureSelfie == nil) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.didCaptureSelfie(selfie);
    });
}

/**
 *  @author Roger Oba
 *
 *  Notifies the View Controller when an error occurs.
 *
 *  @param error NSError instance that represents the occurred error. 
 */
- (void)sendError:(NSError*)error {
    if (self.didError == nil) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.didError(error);
    });
}

@end
