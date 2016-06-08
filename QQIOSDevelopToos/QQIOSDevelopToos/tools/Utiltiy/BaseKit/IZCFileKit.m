//
//  IZCFileKit.m
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "IZCFileKit.h"
#import <CommonCrypto/CommonDigest.h>

#define CheckNSStringIsEmpty(str) ((str==nil)||([str length]==0)||[str isEqualToString:@""]||[str isEqualToString:@"(null)"])

@implementation IZCFileKit

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

+ (NSString *)getFileCacheDirectioryPath
{
    NSString *fileCacheDirectiory = [NSString stringWithFormat:@"%@/DevCache/DevFileCache", [IZCFileKit getCachePath]];
    [self checkCachePath:fileCacheDirectiory];
    return fileCacheDirectiory;
}

+ (NSString *)getFileCacheDocmentPath
{
    NSString *fileCacheDirectiory = [NSString stringWithFormat:@"%@/DevCache/DevFileCache", [IZCFileKit getDocumentPath]];
    [self checkCachePath:fileCacheDirectiory];
    return fileCacheDirectiory;
}

+ (void)checkCachePath:(NSString *)cachePath
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

+ (NSString *)getCacheDirectoryPathWith:(NSString *)appendDirectory
{
    NSString *cacheDirectiory = [NSString stringWithFormat:@"%@/DevCache/%@", [IZCFileKit getCachePath], appendDirectory];
    [self checkCachePath:cacheDirectiory];
    return cacheDirectiory;
}

+ (NSString *)getDocumentDirectoryPathWith:(NSString *)appendDirectory
{
    NSString *documentDirectiory = [NSString stringWithFormat:@"%@/DevCache/%@", [IZCFileKit getDocumentPath], appendDirectory];
    [self checkCachePath:documentDirectiory];
    return documentDirectiory;
}

+ (NSString *)getFilePathWithRelativePath:(NSString *)fileRelativePath
{
    NSString *filePath = [NSString stringWithFormat:@"%@/DevCache/%@", [IZCFileKit getCachePath], fileRelativePath];
    
    return filePath;
}

/* 对key(文件名)进行加密后的路径 */
+ (NSString *)fileCachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return [NSString stringWithFormat:@"%@/%@", [IZCFileKit getFileCacheDirectioryPath], filename];
}
#pragma mark - String
+ (BOOL)saveString:(NSString *)str fileName:(NSString *)fileName
{
    return [IZCFileKit saveString:str
                     fileFullPath:[self fileCachePathForKey:fileName]];
}
+ (NSString *)getStringForFileName:(NSString *)fileName
{
    return [IZCFileKit getStringWithFileFullPath:[self fileCachePathForKey:fileName]];
}

+ (BOOL)saveString:(NSString *)str fileFullPath:(NSString *)fileFullPath
{
    BOOL success = NO;
    NSString *string = [NSString stringWithFormat:@"%@", str];
    if (!CheckNSStringIsEmpty(string))
    {
        success = [string writeToFile:fileFullPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else
    {
        success = NO;
    }
    return success;
}
+ (NSString *)getStringWithFileFullPath:(NSString *)fileFullPath
{
    NSError *error;
    NSString *fileString = [NSString stringWithContentsOfFile:fileFullPath encoding:NSUTF8StringEncoding error:&error];
    if (nil != fileString&&fileString.length>0)
    {
        return fileString;
    }
    return nil;
}

#pragma mark - Object
+ (BOOL)saveObject:(id)object objectType:(FileObjectType)type objectName:(NSString *)objectName
{
    if (FOT_Array == type)
    {// 数组
        NSArray *arrObject = (NSArray *)object;
        return [arrObject writeToFile:[self fileCachePathForKey:objectName] atomically:YES];
    }
    else if (FOT_Dictionary == type)
    {// 字典
        NSDictionary *dicObject = (NSDictionary *)object;
        return [dicObject writeToFile:[self fileCachePathForKey:objectName] atomically:YES];
    }
    return NO;
}
+ (id)getObject:(FileObjectType)objectType objectName:(NSString *)objectName
{
    NSString *filePath = [self fileCachePathForKey:objectName];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExist)
    {
        if (FOT_Array == objectType)
        {
            return [NSArray arrayWithContentsOfFile:filePath];
        }
        else if (FOT_Dictionary == objectType)
        {
            return [NSDictionary dictionaryWithContentsOfFile:filePath];
        }
    }
    return nil;
}
#pragma mark Document
+ (BOOL)saveDocumentObject:(id)object objectType:(FileObjectType)type objectName:(NSString *)objectName
{
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:objectName];
    if (FOT_Array == type)
    {// 数组
        NSArray *arrObject = (NSArray *)object;
        return [arrObject writeToFile:filePath atomically:YES];
    }
    else if (FOT_Dictionary == type)
    {// 字典
        NSDictionary *dicObject = (NSDictionary *)object;
        return [dicObject writeToFile:filePath atomically:YES];
    }
    return NO;
}
+ (id)getDocumentObject:(FileObjectType)objectType objectName:(NSString *)objectName
{
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:objectName];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExist) {
        if (FOT_Array == objectType)
        {
            return [NSArray arrayWithContentsOfFile:filePath];
        }
        else if (FOT_Dictionary == objectType)
        {
            return [NSDictionary dictionaryWithContentsOfFile:filePath];
        }
    }
    return nil;
}
+ (NSString *)getShowStringForFileSize:(long long)fileSize
{
    long long sizeForFile = fileSize;
    NSString *fileStr = nil;
    if (sizeForFile/1024 < 1)
    {
        fileStr = [NSString stringWithFormat:@"%lldb",sizeForFile];  //bt
    }else
    {
        if (sizeForFile/1024 < 1024)
        {
            fileStr = [NSString stringWithFormat:@"%lld.%lldk",sizeForFile/1024,sizeForFile%1024];  //kb
        }else
        {
            if (sizeForFile/1024/1024 < 1024)
            {
                fileStr = [NSString stringWithFormat:@"%lld.%lldM",sizeForFile/1024/1024,sizeForFile%1024];
            }else
            {
                fileStr = [NSString stringWithFormat:@"%lld.%lldG",sizeForFile/1024/1024/1024,sizeForFile%1024];
            }
        }
    }
    return fileStr;
}
//计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float size =0;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    return size;
}

// 移除cache中的file
+ (BOOL)removeCacheFileWithName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager removeItemAtPath:[self fileCachePathForKey:fileName]
                                   error:nil];
}

// 移除document中的file
+ (BOOL)removeDoucumetFileWithName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager removeItemAtPath:[[self getDocumentPath] stringByAppendingPathComponent:fileName] error:nil];
}

@end
