//
//  RSErrorManager.h
//  Real Selfie
//
//  Created by Roger Luan on 12/8/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RS_CAMERA_INIT_ERROR 101
#define RS_INVALID_PARAMETER 102
#define RS_INVALID_EXPORT_PARAMETER 103
#define RS_LOCAL_STORAGE_ERROR 104
#define RS_DATA_FETCHING_ERROR 105


@interface RSErrorManager : NSObject

/**
 *  @author Roger Oba
 *
 *  Returns an error for the given error identifier. Note that the identifier must be expected by the predicted errors in this class, else it'll return an error message claiming it was not an expected error.
 *
 *  @param errorIdentifier An identifier that should be expected in RSErrorManager class defined error values. Hint: The error identifier should start with `RS_`
 *
 *  @return Returns an NSError instance with the given error identifier and meaningful user info.
 */
+ (NSError*)errorForErrorIdentifier:(NSInteger)errorIdentifier;

+ (UIAlertController *)alertFromError:(NSError*)error;

@end
