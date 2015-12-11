//
//  RSCameraViewModel.h
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RSCompletionBlocks.h"

@class RSCameraManager;
@class RSStoreManager;
@class RSDeviceOrientationManager;
@class AVCaptureSession;

@interface RSCameraViewModel : NSObject

@property (nonatomic, copy) didCaptureSelfieBlock didCaptureSelfie;
@property (nonatomic, copy) didReturnErrorBlock didError;

/**
 *  @author Roger Oba
 *
 *  Initializes a new instance of the camera view model with a camera manager and a store manager.
 *
 *  @param cameraManager Camera manager used to initialize the camera view model.
 *  @param storeManager  Store manager used to initialize the camera view model.
 *  @param storeManager  Device orientation manager used to initialize the camera view model.
 *
 *  @return Returns the Camera View Model.
 */
- (instancetype)initWithCamera:(RSCameraManager *)cameraManager storeManager:(RSStoreManager *)storeManager deviceOrientationManager:(RSDeviceOrientationManager *)deviceOrientationManager;

/**
 *  @author Roger Oba
 *
 *  Calls a method from the Model, to capture the user's selfie.
 */
- (void)takeSelfie;

/**
 *  @author Roger Oba
 *
 *  Saves the given selfie to the camera roll and documents directory, in the correct orientation.
 *
 *  @param selfie   Selfie to be saved.
 
 *  @param mirrored mirrored Whether it should be saved mirrored or not (depends on the preview layer current mirroring state)
 *  @param succeed  Success operation block.
 *  @param failure  Failure operation block.
 */
- (void)saveSelfie:(UIImage*)selfie mirrored:(BOOL)mirrored withSuccess:(operationSucceed)succeed failure:(operationFailed)failure;

/**
 *  @author Roger Oba
 *
 *  Simple bridge to call the model method.
 */
- (BOOL)startRunningCamera;

/**
 *  @author Roger Oba
 *
 *  Updates the device orientation if needed.
 *
 *  @param acceleration Recent acceleration, required to determine if the device should change orientation.
 */
- (void)updateDeviceOrientationWithAcceleration:(UIAcceleration *)acceleration;

/**
 *  @author Roger Oba
 *
 *  Calls a method to display the tutorial only if it's the first time the app is running.
 *
 *  @param sender RSCameraViewController instance where the tutorial will be displayed on.
 */
- (void)displayTutorialIfNeededIn:(id)sender animated:(BOOL)animated completion:(tutorialAppearIfNeededBlock)completion;

/**
 *  @author Roger Oba
 *
 *  Calls RSTutorialView instance method to display the tutorial on the top of the sender's view.
 *
 *  @param sender RSCameraViewController instance where the tutorial will be displayed on.
 */
- (void)displayTutorialIn:(id)sender animated:(BOOL)animated completion:(tutorialDidAppearBlock)completion;

/**
 *  @author Roger Oba
 *
 *  Getter method for the Camera Manager Session.
 *
 *  @return Returns the Camera Manager Session.
 */
- (AVCaptureSession*)cameraManagerSession;


- (void)updateTutorialConstraints;

@end
