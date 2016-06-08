//
//  LSFileKit.m
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import "LSFileKit.h"

@implementation LSFileKit

+ (NSString *)getDocumentPath
{
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    return doucumentsDirectiory;
}

+ (NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (BOOL)checkFileIsExist:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

+ (BOOL)moveFileAtPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL result = [fileManager moveItemAtPath:fromPath toPath:toPath error:&error];
    if (error) {
        NSLog(@"%s-error:%@", __func__, [error description]);
    }
    return result;
}

+ (BOOL)copyFileAtPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL result = [fileManager copyItemAtPath:fromPath toPath:toPath error:&error];
    if (error) {
        NSLog(@"%s-error:%@", __func__, [error description]);
    }
    return result;
}

+ (BOOL)renameFileAtPath:(NSString *)filePath rename:(NSString *)name
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:filePath]) {
        // 文件名
//        [filePath lastPathComponent];
        // 去除文件名的路径
        NSString *path = [filePath stringByDeletingPathExtension];
        // 后缀名
        NSString *extension = [filePath pathExtension];
        // 获取在原目录下修改文件名的路径
        NSString *toPath = [NSString stringWithFormat:@"%@/%@.%@", path, name, extension];
        
        NSError *error = nil;
        BOOL result = [fileManager moveItemAtPath:filePath toPath:toPath error:&error];
        if (error) {
            NSLog(@"%s-error:%@", __func__, [error description]);
        }
        return result;
    }
    return NO;
}

@end
