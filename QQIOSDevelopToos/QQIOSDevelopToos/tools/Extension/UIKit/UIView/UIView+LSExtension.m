//
//  UIView+LSExtension.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/15.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "UIView+LSExtension.h"

@implementation UIView (LSLayerExtension)

- (void)setBorder:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

@end
