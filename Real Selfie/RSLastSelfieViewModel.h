//
//  RSLastSelfieViewModel.h
//  Real Selfie
//
//  Created by Roger Luan on 8/26/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RSCompletionBlocks.h"

@class RSStoreManager;
@class RSExportManager;

@interface RSLastSelfieViewModel : NSObject

/**
 *  @author Roger Oba
 *
 *  Initializes a new instance of the last selfie view model with a store manager.
 *
 *  @param storeManager  Store manager used to initialize the camera view model.
 *
 *  @return Returns the Camera View Model.
 */
- (instancetype)initWithManager:(RSStoreManager *)storeManager exportManager:(RSExportManager*)exportManager;

- (void)fetchLastSelfie:(didFetchPhoto)lastSelfie error:(operationFailed)error;
- (void)shareImage:(UIImage*)selfie success:(operationSucceed)succeed orError:(operationFailed)error;

@end
