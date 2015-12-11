//
//  RSLastSelfieViewController+Factory.h
//  Real Selfie
//
//  Created by Roger Luan on 8/28/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "RSLastSelfieViewController.h"

@interface RSLastSelfieViewController (Factory)

/**
 *  @author Roger Oba
 *
 *  Instanciates a new RSLastSelfieViewModel with a new RSStoreManager, and returns a RSLastSelfieViewController.
 *
 *  @return RSLastSelfieViewController A factored View Controller
 */
+ (instancetype)factoryInstance;


@end
