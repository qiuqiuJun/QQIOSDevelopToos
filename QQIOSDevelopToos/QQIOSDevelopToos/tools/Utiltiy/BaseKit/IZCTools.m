//
//  IZCTools.m
//  DevTongXie
//
//  Created by 文夕 on 15/7/6.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "IZCTools.h"
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "QQDefine.h"

@implementation IZCTools

+ (NSString *)filterPhoneToStandardStyle:(NSString *)phoneNumber
{

    NSString *result = phoneNumber;
    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    return result;
}


+ (BOOL) isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *reg = @"^1[2|3|4|5|6|7|8|9][0-9]\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isCorrectPWD:(NSString*)pws
{
    NSString *emailRegex = @"^[0-9a-zA-Z_]{6,12}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:pws];
}


+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validateMKF
{
   __block  BOOL isResult = YES;
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)])
    {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted)
        {
            if (granted)
            {
                isResult =  YES;
            } else
            {
                isResult = NO;
            } 
        }];
    }
         return isResult;
}



+ (BOOL)isAVAuthorization
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (authStatus)
    {
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            return NO;
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            __block BOOL isGranted;
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if(granted)
                {//点击允许访问时调用
                    isGranted = YES;
                }
                else
                {
                    isGranted = NO;
                }
            }];
            return isGranted;
        }
            break;
        case AVAuthorizationStatusAuthorized:
            return YES;
            break;
    }
}

+ (BOOL)isLibraryAuthorization
{
    if (DEV_VERSION_LESS_THAN(@"8.0"))
    {
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        switch (status)
        {
            case ALAuthorizationStatusNotDetermined:
            {
                __block BOOL isAuthorized;
                ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
                [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                    
                    isAuthorized = *stop;
                    
                } failureBlock:^(NSError *error) {
                    
                    isAuthorized = NO;
                }];
                
                return isAuthorized;
            }
                break;
                
            case ALAuthorizationStatusDenied:
            case ALAuthorizationStatusRestricted:
                return NO;
                break;
                
            case ALAuthorizationStatusAuthorized:
                return YES;
                break;
        }
    }else
    {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        switch (status)
        {
            case PHAuthorizationStatusNotDetermined:
            {   __block BOOL isAuthorized;
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
                 {
                     if (status == PHAuthorizationStatusAuthorized)
                     {
                         isAuthorized =  YES;
                     }else
                     {
                         isAuthorized = NO;
                     }
                 }];
                
                return isAuthorized;
            }
                break;
                
            case PHAuthorizationStatusRestricted:
            case PHAuthorizationStatusDenied:
                return NO;
                break;
                
            case PHAuthorizationStatusAuthorized:
                return YES;
                break;
        }
    }
}



/**
 *  @author Rain, 16-04-30 14:04
 *
 *  @brief 验证是否是身份证号码
 *
 *  @param idCodeNub 身份证号码
 *
 *  @return 如果是的话就返回 YES，otherwi NO
 */
+ (BOOL)isIDCardNumber:(NSString *)idCodeNub
{
    NSString *reg = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if (([regextestmobile evaluateWithObject:idCodeNub] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



/**
 *  @author Rain, 16-04-30 14:04
 *
 *  @brief 校验是否是数字
 *
 *  @param numStr
 *
 *  @return
 */
+ (BOOL)isNumber:(NSString *)numStr
{
    NSString *reg = @"[0-9]";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if (([regextestmobile evaluateWithObject:numStr] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
