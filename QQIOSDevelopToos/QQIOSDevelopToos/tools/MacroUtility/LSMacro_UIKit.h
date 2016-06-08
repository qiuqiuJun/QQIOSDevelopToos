//
//  LSMacro_UIKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#ifndef LSMacro_UIKit_h
#define LSMacro_UIKit_h

#pragma mark - UI

// 应用宽高
#define kLSApplicationFrame      [[UIScreen mainScreen] applicationFrame]
#define kLSApplicationFrameSize  [[UIScreen mainScreen] applicationFrame].size

#define kLSApplicationFrameWidth  CGRectGetWidth(kLSApplicationFrame)
#define kLSApplicationFrameHeight CGRectGetHeight(kLSApplicationFrame)

// 屏幕宽高
#define kLSScreenFrame      [[UIScreen mainScreen] bounds]
#define kLSScreenFrameSize  [[UIScreen mainScreen] bounds].size

#define kLSScreenFrameWidth  CGRectGetWidth(kLSScreenFrame)
#define kLSScreenFrameHeight CGRectGetHeight(kLSScreenFrame)


#endif /* LSMacro_UIKit_h */
