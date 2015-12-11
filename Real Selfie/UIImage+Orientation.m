//
//  UIImage+Orientation.m
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "UIImage+Orientation.h"

@implementation UIImage (Orientation)

- (UIImage*)rotateWithSettings:(NSDictionary*)settings {
    return [UIImage imageWithCGImage:[self CGImage] scale:1.0 orientation:[self imageOrientationFromSettings:settings]];
}

- (UIImage*)rotateFromDocumentsWithSettings:(NSDictionary*)settings {
    return [UIImage imageWithCGImage:[self CGImage] scale:1.0 orientation:[self imageOrientationToDocumentsFromSettings:settings]];
}

/**
 *  @author Roger Oba
 *
 *  Returns the correct UIImageOrientation based on the device's current orientation.
 *
 *  @return Correct UIImageOrientation
 */
- (UIImageOrientation) imageOrientationFromSettings:(NSDictionary*)settings {
    BOOL mirrored = [[settings objectForKey:@"mirrored"] boolValue];
    UIInterfaceOrientation photoOrientation = [[settings objectForKey:@"imageOrientation"] integerValue];
    
    if (mirrored) {
        switch (photoOrientation) {
            case UIInterfaceOrientationPortrait: return UIImageOrientationRightMirrored;
            case UIInterfaceOrientationPortraitUpsideDown: return UIImageOrientationLeftMirrored;
            case UIInterfaceOrientationLandscapeRight: return UIImageOrientationDownMirrored;
            case UIInterfaceOrientationLandscapeLeft: return UIImageOrientationUpMirrored;
            case UIInterfaceOrientationUnknown: return UIImageOrientationRightMirrored;
            default: return UIImageOrientationRightMirrored;
        }
    } else {
        switch (photoOrientation) {
            case UIInterfaceOrientationPortrait: return UIImageOrientationRight;
            case UIInterfaceOrientationPortraitUpsideDown: return UIImageOrientationLeft;
            case UIInterfaceOrientationLandscapeRight: return UIImageOrientationDown;
            case UIInterfaceOrientationLandscapeLeft: return UIImageOrientationUp;
            case UIInterfaceOrientationUnknown: return UIImageOrientationRight;
            default: return UIImageOrientationRight;
        }
    }
}

- (UIImageOrientation) imageOrientationToDocumentsFromSettings:(NSDictionary*)settings {
    BOOL mirrored = [[settings objectForKey:@"mirrored"] boolValue];
    UIInterfaceOrientation photoOrientation = [[settings objectForKey:@"imageOrientation"] integerValue];
    
    if (mirrored) {
        switch (photoOrientation) {
            case UIInterfaceOrientationPortrait: return UIImageOrientationLeftMirrored;
            case UIInterfaceOrientationPortraitUpsideDown: return UIImageOrientationRightMirrored;
            case UIInterfaceOrientationLandscapeRight: return UIImageOrientationDownMirrored;
            case UIInterfaceOrientationLandscapeLeft: return UIImageOrientationUpMirrored;
            case UIInterfaceOrientationUnknown: return UIImageOrientationRightMirrored;
            default: return UIImageOrientationRightMirrored;
        }
    } else {
        switch (photoOrientation) {
            case UIInterfaceOrientationPortrait: return UIImageOrientationRight;
            case UIInterfaceOrientationPortraitUpsideDown: return UIImageOrientationLeft;
            case UIInterfaceOrientationLandscapeRight: return UIImageOrientationDown;
            case UIInterfaceOrientationLandscapeLeft: return UIImageOrientationUp;
            case UIInterfaceOrientationUnknown: return UIImageOrientationRight;
            default: return UIImageOrientationRight;
        }
    }
}

@end
