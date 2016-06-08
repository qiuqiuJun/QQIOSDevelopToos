//
//  DevDownLoadSprite.h
//  DevTongXie
//
//  Created by quanqi on 15/10/14.
//  Copyright © 2015年 LoaforSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IZCUpLoadSpriteDelegate;
typedef NS_ENUM(NSInteger, DevUpLoadState)
{
    DevUpLoadQueueIng = 0,               //排队中
    DevUpLoadReady = 1,                  //准备上传
    DevUpLoadIng = 2,                    //正在上传
    DevUpLoadPause = 3,                  //上传暂停
    DevUpLoadSuccess = 4,                //上传成功
    DevUpLoadFail = 5,                   //上传失败
};

@interface IZCUpLoadImageSprite : NSOperation

@property (nonatomic, strong) NSString *upLoadIdentifier;/**< */
@property (nonatomic, assign) DevUpLoadState upLoadState;/**< 下载状态*/
@property (nonatomic, weak) id<IZCUpLoadSpriteDelegate>delegate;/**< delegate*/
@property (nonatomic, assign) CGFloat progress;/**< */
@property (nonatomic, assign) unsigned long bytesSended;//已经接受的数据
/**
 *  @author wqq, 16-05-09 17:05:55
 *
 *  @brief 爱资产图片上传
 *
 *  @param identifier   唯一标识
 *  @param image    图片对象
 *  @param url  上传地址
 *  @param params   参数
 *
 *  @return
 */
- (id)initWithIdentifier:(NSString *)identifier image:(UIImage *)image uploadUrl:(NSString *)url params:(NSDictionary *)params;
/**
 *  开始下载
 */
- (void)startUpload;

/**
 *  停止下载
 */
- (void)stopUpload;


@end

#pragma -mark 下载回调
@protocol IZCUpLoadSpriteDelegate <NSObject>

@optional
/**
 *  连接服务器
 *
 *  @param downSprite
 *  @param identifier
 */
- (void)upLoadSpriteConnectionIng:(IZCUpLoadImageSprite *)upLoadSprite upLoadIdentifier:(NSString*)identifier;

/**
 *  下载中
 *
 *  @param downSprite
 *  @param response
 *  @param identifier
 */
- (void)upLoadSpriteConnection:(IZCUpLoadImageSprite *)upLoadSprite didReceiveResponse:(NSURLResponse *)response upLoadIdentifier:(NSString*)identifier;

/**
 *  接收下载数据
 *
 *  @param downSprite
 *  @param didReceiveProgress 进度
 *  @param identifier
 */
- (void)upLoadSpriteConnection:(IZCUpLoadImageSprite *)upLoadSprite didReceiveProgress:(CGFloat)didReceiveProgress upLoadIdentifier:(NSString*)identifier;

/**
 *
 *  @brief  进度
 *
 *  @param upLoadSprite       精灵对象
 *  @param didReceiveProgress 进度
 *  @param identifier         标志
 *  @param byteSend           已发送的字节数
 *  @param totalSize          总的字节数
 */
- (void)upLoadSpriteConnection:(IZCUpLoadImageSprite *)upLoadSprite didReceiveProgress:(CGFloat)didReceiveProgress upLoadIdentifier:(NSString*)identifier byteSend:(unsigned long)byteSend totalSize:(unsigned long)totalSize;

/**
 *
 *  @brief  下载完成
 *
 *  @param upLoadSprite 精灵对象
 *  @param identifier   文件标志
 *  @param response     返回的参数
 */
- (void)upLoadSpriteConnectionDidFinishLoading:(IZCUpLoadImageSprite *)upLoadSprite upLoadIdentifier:(NSString*)identifier response:(NSString *)response;

/**
 *  下载失败
 *
 *  @param downSprite
 *  @param error
 *  @param identifier
 */
- (void)upLoadSpriteConnection:(IZCUpLoadImageSprite *)upLoadSprite didFailWithError:(NSError *)error upLoadIdentifier:(NSString*)identifier;

/**
 *
 *  @brief  邮件发送专用，需要计算出所有附件总的一个上传进度，所有需要知道每次发出的字节的大小
 *
 *  @param upLoadSprite
 *  @param identifier
 *  @param byteSend
 */
- (void)upLoadSpriteConnection:(IZCUpLoadImageSprite *)upLoadSprite  upLoadIdentifier:(NSString*)identifier byteSend:(unsigned long)byteSend;

@end