//
//  IZCTools.h
//  DevTongXie
//
//  Created by 文夕 on 15/7/6.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//一些工具方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQDefine.h"
@interface IZCTools : NSObject

/**
 *  过滤电话号码，+86 空格 -
 *
 *  @param phoneNumber 为过滤串
 *
 *  @return 过滤串
 */
+ (NSString *)filterPhoneToStandardStyle:(NSString *)phoneNumber;

/**
 *  判断手机格式是否正确
 *
 *  @param mobileNum 字符串
 *
 *  @return 结果
 */

//+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  判断邮箱格式是否正确
 *
 *  @param mobileNum 字符串
 *
 *  @return 结果
 */
+ (BOOL) isEmail:(NSString *)email;

/**
 *  判断用户密码格式是否正确
 *
 *  @param pws 字符串
 *
 *  @return 结果
 */
+(BOOL)isCorrectPWD:(NSString*)pws;

/**
 *  判断是否是email
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *  检测麦克风权限
 *
 *  @return 权限结果
 */
+ (BOOL) validateMKF;


/**
 *  判断相机权限
 *
 *  @return 结果
 */
+ (BOOL)isAVAuthorization;

/**
 *  判断相册权限
 *
 *  @return 结果
 */
+ (BOOL)isLibraryAuthorization;


/**
 *  @author Rain, 16-04-30 14:04
 *
 *  @brief 验证是否是身份证号码
 *
 *  @param idCodeNub 身份证号码
 *
 *  @return 如果是的话就返回 YES，otherwi NO
 */
+ (BOOL)isIDCardNumber:(NSString *)idCodeNub;

/**
 *  @author Rain, 16-04-30 14:04
 *
 *  @brief 校验是否是数字
 *
 *  @param numStr
 *
 *  @return
 */
+ (BOOL)isNumber:(NSString *)numStr;

@end
