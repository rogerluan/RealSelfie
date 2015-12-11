//
//  RSExportManager.m
//  Real Selfie
//
//  Created by Roger Luan on 12/7/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSExportManager.h"
#import "RDActivityViewController.h"
#import "UIViewController+TopViewController.h"
#import <Crashlytics/Crashlytics.h>

static NSString *URLString = @"http://appstore.com/realselfieawysiwygcamera";

@interface RSExportManager () <RDActivityViewControllerDelegate>

@property (strong,nonatomic) UIImage *sharedImage;

@end

@implementation RSExportManager

- (void)displayExportOptionsWithImage:(UIImage*)image success:(operationSucceed)succeed orError:(operationFailed)error {
    if (image) {
        
        self.sharedImage = image;
        RDActivityViewController *activity = [[RDActivityViewController alloc] initWithDelegate:self];
        activity.excludedActivityTypes = @[UIActivityTypeAddToReadingList,UIActivityTypePrint];
        [[UIViewController topViewController] presentViewController:activity animated:YES completion:^{
            succeed();
        }];
    } else {
        error([RSErrorManager errorForErrorIdentifier:RS_INVALID_EXPORT_PARAMETER]);
    }
}

#pragma mark - UIActivityDataSource Method -

- (NSArray*)activityViewController:(NSArray *)activityViewController itemsForActivityType:(NSString *)activityType {
    
    [Answers logShareWithMethod:@"Share Selfie"
                    contentName:nil
                    contentType:activityType
                      contentId:nil
               customAttributes:@{@"class":NSStringFromClass([self class]),@"viewController":@"RSLastSelfieViewController"}];
    
    if ([activityType isEqualToString:UIActivityTypePostToTwitter] || [activityType isEqualToString:UIActivityTypePostToFacebook]) {
        
        NSString *sharingString = NSLocalizedString(@"I just took a selfie and I got exactly what I expected. Wait, how? #RealSelfieCamera #WYSIWYG", nil);
        NSURL *sharingURL = [NSURL URLWithString:URLString];
        return @[sharingString,sharingURL,self.sharedImage];
    } else {
        return @[self.sharedImage];
    }
}

@end
