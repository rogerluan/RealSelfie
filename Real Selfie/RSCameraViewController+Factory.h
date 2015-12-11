//
//  RSCameraViewController+Factory.h
//  Real Selfie
//
//  Created by Roger Luan on 8/10/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSCameraViewController.h"

@interface RSCameraViewController (Factory)

/**
 *  @author Roger Oba
 *
 *  Instanciates a new RSCameraViewModel with a new RSCameraManager and RSStoreManager, and returns a RSCameraViewController.
 *
 *  @return RSCameraViewController A factored View Controller
 */
+ (instancetype)factoryInstance;

@end
