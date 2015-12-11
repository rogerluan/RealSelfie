//
//  RSStoreManager.h
//  Real Selfie
//
//  Created by Roger Luan on 8/28/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RSCompletionBlocks.h"

@interface RSStoreManager : NSObject


/**
 *  @author Roger Oba
 *
 *  Saves an image to the device Camera Roll.
 *
 *  @param photo   The image that you want to be saved.
 *  @param succeed Success operation block, which returns void.
 *  @param error   Error operation block, which returns an NSError object with the given error.
 */
- (void)savePhoto:(UIImage*)photo toCameraRollWithSuccess:(operationSucceed)succeed orError:(operationFailed)error;

/**
 *  @author Roger Oba
 *
 *  Saves an image to the application documents directory.
 *
 *  @param photo      The image that you want to be saved.
 *  @param settings   NSDictionary containing photo display settings
 *  @param succeed    Success operation block, which returns void.
 *  @param error      Error operation block, which returns an NSError object with the given error.
 */
- (void)savePhoto:(UIImage*)photo photoSettings:(NSDictionary*)settings toDocumentsDirectoryWithSuccess:(operationSucceed)succeed orError:(operationFailed)error;

/**
 *  @author Roger Oba
 *
 *  Fetches the last photo from application documents directory.
 *
 *  @param succeed Success operation block that returns the photo found.
 *  @param error   Failure operation block.
 */
- (void)fetchPhotoFromDocumentsDirectoryWithSuccess:(didFetchPhoto)succeed orError:(operationFailed)error;

@end
