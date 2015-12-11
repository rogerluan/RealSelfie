//
//  RSCameraViewController+Factory.m
//  Real Selfie
//
//  Created by Roger Luan on 8/10/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSCameraViewController+Factory.h"
#import "RSCameraManager.h"
#import "RSStoreManager.h"
#import "RSCameraViewModel.h"
#import "RSDeviceOrientationManager.h"

@implementation RSCameraViewController (Factory)

+ (instancetype)factoryInstance {
	RSCameraViewModel *viewModel = [[RSCameraViewModel alloc] initWithCamera:[RSCameraManager new] storeManager:[RSStoreManager new] deviceOrientationManager:[RSDeviceOrientationManager new]];
    return [[RSCameraViewController alloc] initWithModel:viewModel];
}

@end
