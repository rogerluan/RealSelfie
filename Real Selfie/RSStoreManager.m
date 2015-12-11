//
//  RSStoreManager.m
//  Real Selfie
//
//  Created by Roger Luan on 8/28/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSStoreManager.h"
#import <Crashlytics/Crashlytics.h>

static NSString * const imageDataFileName = @"lastSelfie.png";
static NSString * const imageSettingsFileName = @"imageSettings.json";

@interface RSStoreManager();

@property (strong,nonatomic) operationSucceed success;
@property (strong,nonatomic) operationFailed failure;

@end

@implementation RSStoreManager

#pragma mark - Image Persistence
#pragma mark - Persistence Methods

- (void)savePhoto:(UIImage*)photo toCameraRollWithSuccess:(operationSucceed)succeed orError:(operationFailed)error {
	UIImageWriteToSavedPhotosAlbum(photo, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	self.success = succeed;
	self.failure = error;
}

- (void)savePhoto:(UIImage*)photo photoSettings:(NSDictionary*)settings toDocumentsDirectoryWithSuccess:(operationSucceed)succeed orError:(operationFailed)error {
    NSString *imageDataPath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:imageDataFileName];
    NSString *imageSettingsPath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:imageSettingsFileName];
    NSData *data = UIImageJPEGRepresentation(photo, 100);
    
    BOOL settingsSuccess = [settings writeToFile:imageSettingsPath atomically:YES];
    BOOL dataSuccess = [data writeToFile:imageDataPath atomically:YES];
    
    if (settingsSuccess & dataSuccess) {
        [Answers logCustomEventWithName:@"Took & Saved Selfie" customAttributes:@{@"function":@"savePhoto:photoSettings:toDocumentsDirectoryWithSuccess:orError:",@"class":NSStringFromClass([self class]),@"viewController":@"RSCameraViewController",@"photo_settings":settings}];
        succeed();
    } else {
        error([RSErrorManager errorForErrorIdentifier:RS_LOCAL_STORAGE_ERROR]);
    }
}

#pragma mark - Fetch Methods

- (void)fetchPhotoFromDocumentsDirectoryWithSuccess:(didFetchPhoto)succeed orError:(operationFailed)error {
    
	NSString *imageDataPath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:imageDataFileName];
    NSString *imageSettingsPath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:imageSettingsFileName];
    
	UIImage *image = [UIImage imageWithContentsOfFile:imageDataPath];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:imageSettingsPath];
	
	if (image && settings) {
		succeed(image,settings);
	} else {
		error([RSErrorManager errorForErrorIdentifier:RS_DATA_FETCHING_ERROR]);
	}
}

#pragma mark - Auxiliar Methods


/** *
 *  Selector used to handle the `UIImageWriteToSavedPhotosAlbum` completion method.
 *  Note that this is an specific selector used by Apple to send out the possible error and contextInfo on UIImageWriteToSavedPhotosAlbum completion.
 *
 *  @param image       The image that was saved.
 *  @param error       Any possible error that may occurr.
 *  @param contextInfo An optional pointer to any context-specific data.
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
	if (!error) {
		self.success();
	} else {
		self.failure(error);
	}
}

/**
 *  @author Roger Oba
 *
 *  Method that returns the url to the application documents directory.
 *
 *  @return Returns a NSURL object containing the url of the application documents directory.
 */

- (NSURL *)applicationDocumentsDirectory {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
												   inDomains:NSUserDomainMask] lastObject];
}

@end
