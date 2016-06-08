//
//  LSImageKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LSImageKit : NSObject

/**
 *  根据一个色值创建一个UIImage
 *
 *  @param color 颜色值
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
