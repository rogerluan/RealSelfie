//
//  RSDeviceOrientationManager.h
//  Real Selfie
//
//  Created by Roger Luan on 12/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSDeviceOrientationManager : NSObject

/**
 *  @author Roger Oba
 *
 *  Changes the device orientation if needed, based on the device's recent acceleration changes.
 *
 *  @param acceleration Recent acceleration changes.
 */
- (void)updateDeviceOrientationWithAcceleration:(UIAcceleration*)acceleration;

@end
