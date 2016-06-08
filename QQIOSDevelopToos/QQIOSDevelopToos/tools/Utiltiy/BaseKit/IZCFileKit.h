//
//  IZCFileKit.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _FileObjectType
{
    FOT_Array,
    FOT_Dictionary
} FileObjectType;

@interface IZCFileKit : NSObject

/* 得到系统目录 */
+ (NSString *)getDocumentPath;
+ (NSString *)getCachePath;

/* 得到缓存文件所在的目录 */
+ (NSString *)getFileCacheDirectioryPath;

/* 得到Devstore 储存本地的根目录 */
+ (NSString *)getFileCacheDocmentPath;

/*
 检查缓存路径是否存在，如果不存在自动创建
 */
+ (void)checkCachePath:(NSString *)cachePath;

/*
 获取Cache下的路径
 */
+ (NSString *)getCacheDirectoryPathWith:(NSString *)appendDirectory;
/*
 获取Document下的路径
 */
+ (NSString *)getDocumentDirectoryPathWith:(NSString *)appendDirectory;

/*
 用相对路径得到文件的所在目录
 */
+ (NSString *)getFilePathWithRelativePath:(NSString *)fileRelativePath;

// 保存一个字符串数据
+ (BOOL)saveString:(NSString *)str fileName:(NSString *)fileName;
+ (NSString *)getStringForFileName:(NSString *)fileName;

+ (BOOL)saveString:(NSString *)str fileFullPath:(NSString *)fileFullPath;
+ (NSString *)getStringWithFileFullPath:(NSString *)fileFullPath;

// 保存一个字典或者数据 -- 文件名字会被加密
+ (BOOL)saveObject:(id)object objectType:(FileObjectType)type objectName:(NSString *)objectName;
// 得到一个文件  名字是加密的
+ (id)getObject:(FileObjectType)objectType objectName:(NSString *)objectName;

#pragma mark Document
// 保存到一个文件到Document
+ (BOOL)saveDocumentObject:(id)object objectType:(FileObjectType)type objectName:(NSString *)objectName;
// add at 20130924 得到document下的一个文件对象 文件名字是未加密的
+ (id)getDocumentObject:(FileObjectType)objectType objectName:(NSString *)objectName;

//计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path;
+ (NSString *)getShowStringForFileSize:(long long)fileSize;

#pragma mark Remove
// 移除cache中的file
+ (BOOL)removeCacheFileWithName:(NSString *)fileName;
// 移除document中的file
+ (BOOL)removeDoucumetFileWithName:(NSString *)fileName;

@end
