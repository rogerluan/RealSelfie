//
//  RSLastSelfieViewController.m
//  Real Selfie
//
//  Created by Roger Luan on 8/25/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSLastSelfieViewController.h"
#import "RSLastSelfieViewModel.h"
#import "UIImage+Orientation.h"
#import "RSStoreManager.h"
#import "UIViewController+TopViewController.h"
#import <Crashlytics/Crashlytics.h>

@interface RSLastSelfieViewController () <UIScrollViewDelegate,MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property (strong, nonatomic) NSError *setSelfieError;

@property (strong,nonatomic) RSLastSelfieViewModel *viewModel;

@end

@implementation RSLastSelfieViewController

#pragma mark - Lifecycle -

- (instancetype)initWithModel:(RSLastSelfieViewModel*)viewModel {
	self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"lastSelfieVC"];
	if (!self) return nil;
	
	self.viewModel = viewModel;
	self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelfieToImageView];
	[self setupSelfieVisualizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //this property is used to only display the possible setSelfie error once the view appear.
    if (self.setSelfieError) {
        [Answers logCustomEventWithName:@"Set Selfie Error" customAttributes:@{@"function":@"viewDidAppear:",@"class":NSStringFromClass([self class]),@"viewController":NSStringFromClass([self class])}];
        [self presentViewController:[RSErrorManager alertFromError:self.setSelfieError] animated:YES completion:nil];
        self.setSelfieError = nil;
    }
}

#pragma mark - UIScrollView Delegate Method

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}

#pragma mark - Interface Orientation Method

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - IBActions

- (IBAction)tappedCloseButton:(UIButton *)sender {
    [Answers logCustomEventWithName:@"Tap Close Button" customAttributes:@{@"function":@"tappedCloseButton:",@"class":NSStringFromClass([self class]),@"viewController":NSStringFromClass([self class])}];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didSwipeDown:(id)sender {
    [Answers logCustomEventWithName:@"Swipe Down" customAttributes:@{@"function":@"didSwipeDown:",@"class":NSStringFromClass([self class]),@"viewController":NSStringFromClass([self class])}];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tappedShareButton:(UIButton *)sender {
    [self.viewModel shareImage:self.imageView.image success:^{
        NSLog(@"Successfully presented sharing options.");
    } orError:^(NSError *error) {
        [self presentViewController:[RSErrorManager alertFromError:error] animated:YES completion:nil];
    }];
}

#pragma mark - Setup

- (void)setSelfieToImageView {
	[self.viewModel fetchLastSelfie:^(UIImage *photo, NSDictionary *settings) {
        self.imageView.image = [photo rotateFromDocumentsWithSettings:settings];
	} error:^(NSError *error) {
        self.setSelfieError = error;
	}];
}

- (void)setupSelfieVisualizer {
	
	UIViewAutoresizing mask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;;
	
	self.scrollView.autoresizingMask = mask;
	self.scrollView.delegate = self;
	self.scrollView.maximumZoomScale = 6;
	
	self.imageView.autoresizingMask = mask;
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark - Mail Compose View Controller Delegate Method -

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
