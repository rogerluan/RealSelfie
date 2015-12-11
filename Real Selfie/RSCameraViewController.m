//
//  ViewController.m
//  Real Selfie
//
//  Created by Roger Oba on 8/4/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import <Crashlytics/Crashlytics.h>
#import "RSPreviewLayer.h"
#import "RSCameraManager.h"
#import "UIImage+Orientation.h"
#import "RSCameraViewModel.h"
#import "RSTutorialView.h"
#import "RSLastSelfieViewController+Factory.h"
#import <MessageUI/MessageUI.h>

@interface RSCameraViewController () <UIGestureRecognizerDelegate,UIAccelerometerDelegate,RSTutorialDelegate>

@property (strong,nonatomic) RSCameraViewModel *viewModel;
@property (strong,nonatomic) RSPreviewLayer *previewLayer;
@property (strong,nonatomic) UIVisualEffectView *visualEffectView;

@property (strong, nonatomic) IBOutlet UILabel *cameraStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *tutorialButton;

//UIGestureRecognizers
@property (strong,nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (strong,nonatomic) IBOutlet UISwipeGestureRecognizer *horizontalSwipeGesture;
@property (strong,nonatomic) IBOutlet UISwipeGestureRecognizer *swipeUpGesture;

@end

@implementation RSCameraViewController

#pragma mark - View Controller Lifecycle

- (instancetype)initWithModel:(RSCameraViewModel*)viewModel {
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mainVC"];
    if (!self) { return nil; }
    self.viewModel = viewModel;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindToModel];
    [self setupMotionManager];
    [self setupPreviewLayer];
    
    self.horizontalSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    
    [self.viewModel displayTutorialIfNeededIn:self animated:NO completion:^(BOOL neededAndDisplayed) {
        if (neededAndDisplayed) {
            [self disableGestures];
        } else {
            NSLog(@"Tutorial has already been displayed before.");
        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.previewLayer changeOrientationTo:self.interfaceOrientation];
    self.previewLayer.frame = self.view.frame;
}

#pragma mark - UIInterfaceOrientation Delegate Methods

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.previewLayer.frame = self.view.frame;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.previewLayer changeOrientationTo:toInterfaceOrientation];
    [self.viewModel updateTutorialConstraints];
}

#pragma mark - UIAccelerometer Delegate Methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    [self.viewModel updateDeviceOrientationWithAcceleration:acceleration];
}

#pragma mark - ViewModel

/**
 *  @author Roger Oba
 *
 *  Binds the View Model to the View Controller.
 */
- (void)bindToModel {
    self.viewModel.didCaptureSelfie = [self modelDidCaptureSelfie];
    self.viewModel.didError = [self modelDidReturnError];
}

/**
 *  @author Roger Oba
 *
 *  This method will return a block from View Model, therefore it will only return when the View Model updates the didCaptureSelfie property. In this method, a selfie is returned within the block, so it is then rotated to the proper orientation and saved to the Camera Roll.
 *
 *  @return didCaptureSelfieBlock A block that should return the selfie that was captured from the Camera Manager.
 */
- (didCaptureSelfieBlock) modelDidCaptureSelfie {
    return ^(UIImage *selfie){
		[self.viewModel saveSelfie:selfie mirrored:self.previewLayer.isMirrored withSuccess:^{
			NSLog(@"Successfully saved the selfie.");
		} failure:^(NSError *error) {
            [self presentViewController:[RSErrorManager alertFromError:error] animated:YES completion:nil];
		}];
    };
}

/**
 *  @author Roger Oba
 *
 *  This methodwill return a block from View Model, therefore it will only return when (and if) the View Model updates the didError property. In this method, an error is returned within the block, and it is then displayed to the user in an UIAlertController
 *
 *  @return didReturnErrorBlock A block that should return the error that was sent by the View Model.
 */
- (didReturnErrorBlock) modelDidReturnError {
    return ^(NSError *error) {
        [self presentViewController:[RSErrorManager alertFromError:error] animated:YES completion:nil];
    };
}

#pragma mark - User Interface Methods

/**
 *  @author Roger Oba
 *
 *  Creates a camera flash effect view and displays it with animation.
 */
- (void)showPhotoCaptureFlash {
    UIView *screenflash = [[UIView alloc] initWithFrame:self.view.frame];
    screenflash.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration: 0.1 animations: ^{
        screenflash.alpha = 1.0;
        [self.view addSubview:screenflash];
    } completion: ^(BOOL finished) {
        [UIView animateWithDuration: 0.5 animations: ^{
            screenflash.alpha = 0.0;
        } completion: ^(BOOL finished) {
            [screenflash removeFromSuperview];
        }];
    }];
}

#pragma mark - Gestures Methods

/**
 *  @author Roger Oba
 *
 *  IBAction called when user taps on the screen.
 *  It triggers showPhotoCaptureFlash method and viewModel's takeSelfie method.
 *
 *  @param sender The UITapGestureRecognizer which sent the gesture event.
 */
- (IBAction) didTap:(UITapGestureRecognizer *)sender {
    [self showPhotoCaptureFlash];
    [self.viewModel takeSelfie];
}

/**
 *  @author Roger Oba
 *
 *  IBAction called when user swipes horizontally on the screen.
 *  It mirrors the camera preview layer and updates the camera status label with animation.
 *
 *  @param sender The UISwipeGestureRecognizer which sent the gesture event.
 */
- (IBAction)didHorizontalSwipe:(UISwipeGestureRecognizer *)sender {
    self.cameraStatusLabel.alpha = 0.0f;
    [UIView animateWithDuration:0.5 animations:^{
        [self.previewLayer mirrorLayer];
    } completion:^(BOOL finished) {
        self.cameraStatusLabel.text = self.previewLayer.cameraStatus;
        [UIView animateWithDuration:1.0 animations:^{
            self.cameraStatusLabel.alpha = 1.0f;
        }];
    }];
}

/**
 *  @author Roger Oba
 *
 *  IBAction called when user swipes up on the screen.
 *  It displays a modal view controller containing the last taken selfie, with options to edit and share.
 *
 *  @param sender The UISwipeGestureRecognizer which sent the gesture event.
 */
- (IBAction)didSwipeUp:(UISwipeGestureRecognizer *)sender {
	
	RSLastSelfieViewController *lastSelfieVC = [RSLastSelfieViewController factoryInstance];
	[self presentViewController:lastSelfieVC animated:YES completion:^{
//        [lastSelfieVC setSelfieToImageView];
    }];
	
    //TODO: Add sharing options
    //TODO: Add editting tools to the photo
}

- (IBAction)displayTutorial:(id)sender {
    [self.viewModel displayTutorialIn:self animated:YES completion:^{
        [self disableGestures];
    }];
}


/**
 *  @author Roger Oba
 *
 *  Disables the app gestures. Should be called when presenting the tutorial view, to temporary prevent the user to interact with the main view.
 */
- (void)disableGestures {
    self.tapGesture.enabled = NO;
    self.horizontalSwipeGesture.enabled = NO;
    self.swipeUpGesture.enabled = NO;
}

/**
 *  @author Roger Oba
 *
 *  Enables the app gestures. Should be called after dismissing the tutorial view, to re-enable the interaction with the main view.
 */
- (void)enableGestures {
    self.tapGesture.enabled = YES;
    self.horizontalSwipeGesture.enabled = YES;
    self.swipeUpGesture.enabled = YES;
}

#pragma mark - Setup Methods -

- (void)setupMotionManager {
    //    CMMotionManager *motionManager = [CMMotionManager new];
    //    [motionManager setAccelerometerUpdateInterval:0.1];
    //    [motionManager startAccelerometerUpdates];
    //TODO: Update UIAccelerometer to CMMotionManager
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1];
}

- (void)setupPreviewLayer {
    self.previewLayer = [[RSPreviewLayer alloc] initWithSession:[self.viewModel cameraManagerSession] frame:self.view.frame];
    [self.view.layer insertSublayer:self.previewLayer below:self.cameraStatusLabel.layer];
    [self.view.layer insertSublayer:self.tutorialButton.layer above:self.previewLayer];
    [self.viewModel startRunningCamera];
}

#pragma mark - Tutorial View Delegate Method -

- (void)tutorialView:(nonnull RSTutorialView *)tutorialView wasDismissed:(nullable tutorialDismissionBlock)completionHandler {
    [self enableGestures];
}

@end
