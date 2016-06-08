//
//  NSData+MD5.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/13.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Addtions)

/**
 *  获取NSData对应的md5值
 */
@property (nonatomic, readonly) NSString* md5Hash;


@end