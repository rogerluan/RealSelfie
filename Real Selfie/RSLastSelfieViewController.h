//
//  RSLastSelfieViewController.h
//  Real Selfie
//
//  Created by Roger Luan on 8/25/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSLastSelfieViewModel;

@interface RSLastSelfieViewController : UIViewController

- (instancetype)initWithModel:(RSLastSelfieViewModel*)viewModel;
- (void)setSelfieToImageView;

@end
