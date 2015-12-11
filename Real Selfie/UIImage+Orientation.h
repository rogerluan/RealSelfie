//
//  UIImage+Orientation.h
//  Real Selfie
//
//  Created by Roger Luan on 8/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Orientation)

/**
 *  @author Roger Oba
 *
 *  Fixes the image orientation based on the given settings, which should include image mirroring and photo orientation.
 *
 *  @param settings Dictionary containing photo settings
 *
 *  @return The image with the correct orientation
 */
- (UIImage*)rotateWithSettings:(NSDictionary*)settings;


/**
 *  @author Roger Oba
 *
 *  Fixes the image orientation based on the given settings, which should include image mirroring and photo orientation. This method should be used when fetching an image from the documents folder.
 *
 *  @param settings Dictionary containing photo settings
 *
 *  @return The image with the correct orientation
 */
- (UIImage*)rotateFromDocumentsWithSettings:(NSDictionary*)settings;

@end
