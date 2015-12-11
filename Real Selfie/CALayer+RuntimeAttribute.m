//
//  CALayer+RuntimeAttribute.m
//  Real Selfie
//
//  Created by Roger Luan on 12/9/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "CALayer+RuntimeAttribute.h"

@implementation CALayer (IBConfiguration)

- (void)setBorderIBColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderIBColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
