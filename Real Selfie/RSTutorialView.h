//
//  RSTutorialView.h
//  Real Selfie
//
//  Created by Roger Luan on 8/10/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCompletionBlocks.h"

@class RSCameraViewController;

@protocol RSTutorialDelegate;

@interface RSTutorialView : UIView

@property (strong,nonatomic,nonnull) id<RSTutorialDelegate> delegate;
@property (assign,nonatomic) BOOL animated;

- (void)displayTutorialIn:(nonnull RSCameraViewController*)viewController completion:(nonnull tutorialDidAppearBlock)completion;
- (void)updateVisualEffectViewConstraints;

@end

@protocol RSTutorialDelegate <NSObject>

@optional
- (void)tutorialView:(nonnull RSTutorialView*)tutorialView wasDismissed:(nullable tutorialDismissionBlock)completionHandler;

@end