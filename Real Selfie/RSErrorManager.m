//
//  RSErrorManager.m
//  Real Selfie
//
//  Created by Roger Luan on 12/8/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSErrorManager.h"
#import <MessageUI/MessageUI.h>
#import "RSCameraViewModel.h"
#import "UIViewController+TopViewController.h"

@interface RSErrorManager () <MFMailComposeViewControllerDelegate>

@end

@implementation RSErrorManager

+ (NSError*)errorForErrorIdentifier:(NSInteger)errorIdentifier {
    return [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier]
                                                code:errorIdentifier
                                            userInfo:[self userInfoForError:errorIdentifier]];
}

+ (UIAlertController *)alertFromError:(NSError *)error {
    NSLog(@"An error occured. Error description: %@. Possible failure reason: %@",error.localizedDescription,error.localizedFailureReason);
    
    switch (error.code) {
        case RS_INVALID_EXPORT_PARAMETER: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Invalid Selfie",nil) message:NSLocalizedString(@"You are trying to export. But first! Lemme take a selfie.",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIViewController topViewController] dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            return alert;
        }
        case RS_DATA_FETCHING_ERROR: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Couldn't Find Selfie",nil) message:NSLocalizedString(@"We couldn't find your selfie. Maybe you haven't taken any selfies yet!",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take Selfie",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIViewController topViewController] dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [alert addAction:cancelAction];
            return alert;
        }
        default: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Oops...",nil) message:NSLocalizedString(@"An internal error occured. If this error prevented you from doing something, please contact us.",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"Contact Us",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([MFMailComposeViewController canSendMail]) {
                    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
                    [composeViewController setToRecipients:@[@"rogerluan.oba@gmail.com"]];
                    [composeViewController setSubject:NSLocalizedString(@"Real Selfie Bug Report", @"`Real Selfie` shouldn't be localized because it's the name of the app.")];
                    [composeViewController setMessageBody:[NSString stringWithFormat:NSLocalizedString(@"\n\n\nError code:%ld", nil),(long)error.code] isHTML:NO];
                    composeViewController.mailComposeDelegate = (id)[UIViewController topViewController];
                    [[UIViewController topViewController] presentViewController:composeViewController animated:YES completion:nil];
                } else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Mail Unavailable", ) message:NSLocalizedString(@"Your device isn't configured to send emails. Please contact me at rogerluan.oba@gmail.com",nil) preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:cancelAction];
                    [[UIViewController topViewController] presentViewController:alert animated:YES completion:nil];
                }
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"No Thanks", @"Alert Controler Cancel Button") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [alert addAction:cancelAction];
            return alert;
        }
    }
}

+ (NSDictionary*)userInfoForError:(NSInteger)error {
    switch (error) {
        case RS_CAMERA_INIT_ERROR:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Couldn't start running the camera.", nil),
                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Camera manager was not successfully initialized.", nil)
                     };
        case RS_INVALID_PARAMETER:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"One or more parameters are not valid.", nil),
                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The parameter received is either null, or does not comply with the expected kind or value.", nil)
                     };
        case RS_INVALID_EXPORT_PARAMETER:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"The image you're trying to export isn't valid.", nil),
                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Maybe you haven't taken any selfie yet.", nil)
                     };
        case RS_LOCAL_STORAGE_ERROR:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"The image data or image settings couldn't be saved in the documents directory.", nil),
                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Something system-side went wrong while saving the photo to the documents directory.", nil)
                     };
        case RS_DATA_FETCHING_ERROR:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Failed to fetch the image data or image settings from documents directory.", nil),
                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Maybe there isn't any photo there yet.", nil)
                     };
        default:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid error.", nil),
                     NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The error generated isn't a valid and expected error.", nil)
                     };
    }
}

@end
