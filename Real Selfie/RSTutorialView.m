//
//  RSTutorialView.m
//  Real Selfie
//
//  Created by Roger Luan on 8/10/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSTutorialView.h"
#import "RSCameraViewController.h"

@interface RSTutorialView();

@property (strong,nonatomic) UIVisualEffectView *visualEffectView;

@end

@implementation RSTutorialView

- (void)awakeFromNib {
    self.frame = [[UIScreen mainScreen] bounds];
}

- (instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:@"RSTutorialView" owner:self.superview options:nil] firstObject];
    
    if (!self) { return nil; }

    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tutorialWasTapped)]];
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	self.visualEffectView.frame = self.frame;
    
    return self;
}

#pragma mark - Display Tutorial

- (void)displayTutorialIn:(nonnull RSCameraViewController*)viewController completion:(nonnull tutorialDidAppearBlock)completion {
    if (self.animated) {
        self.alpha = 0.0f;
        self.visualEffectView.alpha = 0.0f;
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.alpha = 1.0f;
                             self.visualEffectView.alpha = 1.0f;
                             [viewController.view addSubview:self.visualEffectView];
                             [viewController.view insertSubview:self aboveSubview:self.visualEffectView];
                         } completion:^(BOOL finished) {
                             completion();
                         }];
    } else {
        [viewController.view addSubview:self.visualEffectView];
        [viewController.view insertSubview:self aboveSubview:self.visualEffectView];
        completion();
    }
}

- (void)updateVisualEffectViewConstraints {
    CGRect currentScreenFrame = [[UIScreen mainScreen] bounds];
    self.visualEffectView.frame = CGRectMake(0, 0, currentScreenFrame.size.height, currentScreenFrame.size.width);
}

#pragma mark - Gesture Handling

- (void)tutorialWasTapped {
    [self tutorialView:self wasDismissed:^{
        [self.delegate tutorialView:self wasDismissed:nil];
    }];
}

#pragma mark - Delegate Methods

/**
 *  @author Roger Oba
 *
 *  RSTutorialView delegate method that returns a completion block when the tutorial view is dismissed.
 *
 *  @param tutorialView      The tutorial view that was dismissed.
 *  @param completionHandler A void completion handler block.
 */
- (void)tutorialView:(RSTutorialView*)tutorialView wasDismissed:(tutorialDismissionBlock)completionHandler {

    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self.visualEffectView.alpha = 0;
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.visualEffectView removeFromSuperview];
                         [self removeFromSuperview];
                         completionHandler();
                     }];
}

@end
