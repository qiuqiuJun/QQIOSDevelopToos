//
//  LSMacroUtility.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#ifndef LSMacroUtility_h
#define LSMacroUtility_h

#import "LSMacro_UIKit.h"

#pragma mark - Base
#define LSIsVaildObject(obj) ((obj) != nil && ![obj isKindOfClass:[NSNull class]])

#pragma mark - UIFont
#define LSSystemFontOfSize(size) [UIFont systemFontOfSize:size]
#define LSBoldSystemFontOfSize(size) [UIFont boldSystemFontOfSize:size]


#define kLSScreenScale [UIScreen mainScreen].scale

#pragma mark SystemVersion
#define LSCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define LS_IOS_4_3 (LSCurrentSystemVersion>=4.3)
#define LS_IOS_5_0 (LSCurrentSystemVersion>=5.0)
#define LS_IOS_6_0 (LSCurrentSystemVersion>=6.0)
#define LS_IOS_7_0 (LSCurrentSystemVersion>=7.0)
#define LS_IOS_8_0 (LSCurrentSystemVersion>=8.0)
#define LS_IOS_9_0 (LSCurrentSystemVersion>=9.0)
#define LS_IOS7_OriginY (LS_IOS_7_0?20:0)

#pragma mark Device

#define LS_SCREEN_MAX_LENGTH (MAX(kLSScreenFrameWidth, kLSScreenFrameHeight))
#define LS_SCREEN_MIN_LENGTH (MIN(kLSScreenFrameWidth, kLSScreenFrameHeight))

#define LS_IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define LS_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define LS_IS_RETINA (kLSScreenScale >= 2.0)

#define LS_IS_IPHONE_4_OR_LESS (LS_IS_IPHONE && LS_SCREEN_MAX_LENGTH < 568.0)
#define LS_IS_IPHONE_5         (LS_IS_IPHONE && LS_SCREEN_MAX_LENGTH == 568.0)
#define LS_IS_IPHONE_6         (LS_IS_IPHONE && LS_SCREEN_MAX_LENGTH == 667.0)
#define LS_IS_IPHONE_6P        (LS_IS_IPHONE && LS_SCREEN_MAX_LENGTH == 736.0)



#endif /* LSMacroUtility_h */
