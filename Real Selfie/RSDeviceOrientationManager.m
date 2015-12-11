//
//  RSDeviceOrientationManager.m
//  Real Selfie
//
//  Created by Roger Luan on 12/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSDeviceOrientationManager.h"

@interface RSDeviceOrientationManager()

@property (nonatomic) UIInterfaceOrientation deviceOrientation;

@end

@implementation RSDeviceOrientationManager

- (void)updateDeviceOrientationWithAcceleration:(UIAcceleration*)acceleration {
    // Get the current device angle
    float xx = -[acceleration x];
    float yy = [acceleration y];
    float angle = atan2(yy, xx);
    
    if (acceleration.z >= -0.90 && acceleration.z <= 0.90) {
        if(angle >= -2.25 && angle <= -0.25) {
            if(self.deviceOrientation != UIInterfaceOrientationPortrait) {
                self.deviceOrientation = UIInterfaceOrientationPortrait;
                NSNumber *value = [NSNumber numberWithInt:self.deviceOrientation];
                [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                NSLog(@"UIInterfaceOrientationPortrait");
            }
        } else if(angle >= -1.75 && angle <= 0.75) {
            if(self.deviceOrientation != UIInterfaceOrientationLandscapeRight) {
                self.deviceOrientation = UIInterfaceOrientationLandscapeRight;
                NSNumber *value = [NSNumber numberWithInt:self.deviceOrientation];
                [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                NSLog(@"UIInterfaceOrientationLandscapeRight");
            }
        } else if(angle >= 0.75 && angle <= 2.25) {
            if(self.deviceOrientation != UIInterfaceOrientationPortraitUpsideDown) {
                self.deviceOrientation = UIInterfaceOrientationPortraitUpsideDown;
                NSNumber *value = [NSNumber numberWithInt:self.deviceOrientation];
                [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
            }
        } else if(angle <= -2.25 || angle >= 2.25) {
            if(self.deviceOrientation != UIInterfaceOrientationLandscapeLeft) {
                self.deviceOrientation = UIInterfaceOrientationLandscapeLeft;
                NSNumber *value = [NSNumber numberWithInt:self.deviceOrientation];
                [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                NSLog(@"UIInterfaceOrientationLandscapeLeft");
            }
        }
    } else {
        //        NSLog(@"Device is on horizontal plane.");
    }
}

@end
