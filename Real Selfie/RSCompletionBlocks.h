//
//  RSCompletionBlocks.h
//  Real Selfie
//
//  Created by Roger Luan on 8/13/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSErrorManager.h"
#import <MessageUI/MessageUI.h>

#ifndef RSCompletionBlocks_h
#define RSCompletionBlocks_h

typedef void(^didTakeSelfie)(UIImage *selfie,NSError *error);
typedef void(^didCaptureSelfieBlock)(UIImage *selfie);
typedef void(^didReturnErrorBlock)(NSError *error);

typedef void(^tutorialDismissionBlock)(void);
typedef void(^tutorialDidAppearBlock)(void);
typedef void(^tutorialAppearIfNeededBlock)(BOOL neededAndDisplayed);

typedef void(^operationSucceed)(void);
typedef void(^operationFailed)(NSError *error);

typedef void(^didFetchPhoto)(UIImage *photo,NSDictionary *settings);


#endif /* RSCompletionBlocks_h */

