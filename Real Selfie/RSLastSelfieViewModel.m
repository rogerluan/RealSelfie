//
//  RSLastSelfieViewModel.m
//  Real Selfie
//
//  Created by Roger Luan on 8/26/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSLastSelfieViewModel.h"
#import "RSStoreManager.h"
#import "RSExportManager.h"

@interface RSLastSelfieViewModel();

@property (strong,nonatomic) RSStoreManager *storeManager;
@property (strong,nonatomic) RSExportManager *exportManager;

@end

@implementation RSLastSelfieViewModel

- (instancetype)initWithManager:(RSStoreManager *)storeManager exportManager:(RSExportManager*)exportManager{
	if (!(self = [super init])) return nil; //if can't init, quit.
	
    self.exportManager = exportManager;
	self.storeManager = storeManager;
	return self;
}

- (void)fetchLastSelfie:(didFetchPhoto)lastSelfie error:(operationFailed)error {
	[self.storeManager fetchPhotoFromDocumentsDirectoryWithSuccess:^(UIImage *photo,NSDictionary *settings) {
		lastSelfie(photo,settings);
	} orError:^(NSError *errorMessage) {
		error(errorMessage);
	}];
}

- (void)shareImage:(UIImage*)selfie success:(operationSucceed)succeed orError:(operationFailed)error{
    [self.exportManager displayExportOptionsWithImage:selfie success:^{
        succeed();
    } orError:^(NSError *operationError) {
        error(operationError);
    }];
}

@end
