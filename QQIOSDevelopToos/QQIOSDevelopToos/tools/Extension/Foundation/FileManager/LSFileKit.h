//
//  LSFileKit.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSFileKit : NSObject

/**
 *  得到沙盒内的Document目录
 *
 *  @return Document目录路径
 */
+ (NSString *)getDocumentPath;

/**
 *  得到沙盒内的Cache目录
 *
 *  @return Cache目录路径
 */
+ (NSString *)getCachePath;

/**
 *  检查文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return YES存在 NO不存在
 */
+ (BOOL)checkFileIsExist:(NSString *)filePath;

/**
 *  移动文件
 *
 *  @param fromPath 需要移动的文件所在的路径
 *  @param toPath   移动到的目标路径
 *
 *  @return YES移动成功 NO移动失败
 */
+ (BOOL)moveFileAtPath:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 *  复制文件
 *
 *  @param fromPath 需要复制的文件所在的路径
 *  @param toPath   复制到的目标路径
 *
 *  @return YES复制成功 NO复制失败
 */
+ (BOOL)copyFileAtPath:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 *  重命名一个文件
 *
 *  @param fromPath 文件所在的路径
 *  @param name     重命名的名字-只写名字，会自动获取后缀
 *
 *  @return 返回结果
 */
+ (BOOL)renameFileAtPath:(NSString *)filePath rename:(NSString *)name;

@end
