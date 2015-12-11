//
//  RSLastSelfieViewController+Factory.m
//  Real Selfie
//
//  Created by Roger Luan on 8/28/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSLastSelfieViewController+Factory.h"
#import "RSLastSelfieViewModel.h"
#import "RSStoreManager.h"
#import "RSExportManager.h"

@implementation RSLastSelfieViewController (Factory)

+ (instancetype)factoryInstance {
	RSLastSelfieViewModel *viewModel = [[RSLastSelfieViewModel alloc] initWithManager:[RSStoreManager new] exportManager:[RSExportManager   new]];
	return [[RSLastSelfieViewController alloc] initWithModel:viewModel];
}

@end
