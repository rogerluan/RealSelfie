//
//  RSExportManager.h
//  Real Selfie
//
//  Created by Roger Luan on 12/7/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RSCompletionBlocks.h"

@interface RSExportManager : NSObject

/**
 *  @author Roger Oba
 *
 *  Displays an UIActivityViewController with the available sharing options.
 *
 *  @param image Image that's going to be shared.
 *  @param succeed    Success operation block, which returns void.
 *  @param error      Error operation block, which returns an NSError object with the given error.
 */
- (void)displayExportOptionsWithImage:(UIImage*)image success:(operationSucceed)succeed orError:(operationFailed)error;

@end
