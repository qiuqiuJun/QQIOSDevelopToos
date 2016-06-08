//
//  QQDefine.h
//  QQIOSDevelopToos
//
//  Created by quanqi on 16/6/8.
//  Copyright © 2016年 devstore. All rights reserved.
//

#ifndef QQDefine_h
#define QQDefine_h

#define DevGetColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DevSystemFontOfSize(size) [UIFont systemFontOfSize:size]

// 屏幕宽高
#define kHLScreenFrame      [[UIScreen mainScreen] bounds]
#define kHLScreenFrameSize  [[UIScreen mainScreen] bounds].size

#define kHLScreenFrameWidth  kHLScreenFrameSize.width
#define kHLScreenFrameHeight kHLScreenFrameSize.height

#define DevCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define Dev_IOS_4_3 (DevCurrentSystemVersion>=4.3)
#define Dev_IOS_5_0 (DevCurrentSystemVersion>=5.0)
#define Dev_IOS_6_0 (DevCurrentSystemVersion>=6.0)
#define Dev_IOS_7_0 (DevCurrentSystemVersion>=7.0)
#define Dev_IOS_8_0 (DevCurrentSystemVersion>=8.0)
#define Dev_IOS_9_0 (DevCurrentSystemVersion>=9.0)
#define Dev_IOS7_OriginY (Dev_IOS_7_0?20:0)

#define DEV_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#endif /* QQDefine_h */
