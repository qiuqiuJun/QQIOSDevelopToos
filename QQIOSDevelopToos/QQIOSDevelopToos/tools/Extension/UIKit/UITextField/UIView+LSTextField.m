//
//  UIView+LSTextField.m
//  iZichanSalary
//
//  Created by LoaforSpring on 16/5/17.
//  Copyright © 2016年 YiZhan. All rights reserved.
//

#import "UIView+LSTextField.h"

#import <objc/runtime.h>

static NSString *const kLSOriginY = @"kLSOriginY";
static NSString *const kLSOriginYHaved = @"kLSOriginYHaved";

static NSString *const kLSOriginYOffset = @"kLSOriginYOffset";

@implementation UIView (LSTextField)

- (void)setLsOriginY:(CGFloat)lsOriginY
{
    // 因为类别无法扩充属性，使用runtime，进行运行时保存
    objc_setAssociatedObject (self, &kLSOriginY, [NSNumber numberWithFloat:lsOriginY], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)lsOriginY
{
    NSNumber *originYObj = objc_getAssociatedObject(self, &kLSOriginY);
    if (originYObj) {
        return [originYObj floatValue];
    }
    return 0;
}
- (void)setLsOriginYHaved:(BOOL)lsOriginYHaved
{
    objc_setAssociatedObject (self, &kLSOriginYHaved, [NSNumber numberWithBool:lsOriginYHaved], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)lsOriginYHaved
{
    NSNumber *originYObj = objc_getAssociatedObject(self, &kLSOriginYHaved);
    if (originYObj) {
        return [originYObj boolValue];
    }
    return NO;
}

- (void)setLsOriginYOffset:(CGFloat)lsOriginYOffset
{
    objc_setAssociatedObject (self, &kLSOriginYOffset, [NSNumber numberWithFloat:lsOriginYOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)lsOriginYOffset
{
    NSNumber *offsetObj = objc_getAssociatedObject(self, &kLSOriginYOffset);
    if (offsetObj) {
        return [offsetObj floatValue];
    }
    return 0;
}

@end