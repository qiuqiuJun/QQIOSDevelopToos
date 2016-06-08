//
//  DevDownLoadSprite.m
//  DevTongXie
//
//  Created by quanqi on 15/10/14.
//  Copyright © 2015年 LoaforSpring. All rights reserved.
//

#import "IZCUpLoadImageSprite.h"
#import "QQDefine.h"
//#import "IZCUserManager.h"
#define kDefaultFlowKey @"uploadFile"

@interface IZCUpLoadImageSprite()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (nonatomic, strong) NSString *upLoadUrl;/**< 上传地址*/
@property (nonatomic, strong) NSString *fullPath;/**< 本地保存地址*/
@property (nonatomic, assign) unsigned  long start;//已经上传的数据，告诉服务器从哪里开始上传
@property (nonatomic, strong) NSURLConnection* urlconnection;
@property (nonatomic, strong) NSURLResponse *upLoadResponse;
@property (nonatomic, strong) NSString *localFilePath;/**< 本地文件路径*/
@property (nonatomic, strong) NSDictionary *parms;/**< 参数*/
@property (nonatomic, strong) NSString *flowKey;/**< 流对应的key*/
@property (nonatomic, strong) NSString *fileSuffix;/**< 文件后缀*/
@property (nonatomic, strong) NSMutableData *responseData;/**< 返回的数据*/
@property (nonatomic, assign) unsigned  long totalSize;//文件总大小
@property (nonatomic, assign) unsigned  long bodyHeadSize;/**< 请求body中文件data之前的大小*/
@property (nonatomic, assign) unsigned  long bodyEndSize;/**< 请求body中文件data之后的大小*/
@property (nonatomic, assign) unsigned  long bodyTotalSize;/**< 请求body总的大小*/
@property (nonatomic, strong) NSData *fileData;/**< 文件data*/
@property (nonatomic, strong) NSData *expectedData;/**< 要上传的data*/
@property (nonatomic, strong) NSString *userCertificate;/**< */
@property (nonatomic, strong) NSDictionary *httpRequestHeadDic;/**< 请求的头字典*/
@property (nonatomic, strong) UIImage *uploadImage;/**< */

@end
@implementation IZCUpLoadImageSprite

- (void)dealloc
{
    if (_delegate) _delegate = nil;
    if (_urlconnection) _urlconnection = nil;
    if (_upLoadResponse) _upLoadResponse = nil;
    if (_httpRequestHeadDic) _httpRequestHeadDic = nil;
    if (_parms) _parms = nil;
    if (_responseData) _responseData = nil;
    if (_fileData) _fileData = nil;
    if (_expectedData) _expectedData = nil;
    self.uploadImage = nil;
}

//爱资产新加的上传方法
- (id)initWithIdentifier:(NSString *)identifier image:(UIImage *)image uploadUrl:(NSString *)url params:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.upLoadIdentifier = identifier;
        self.upLoadUrl = url;
        self.upLoadState = DevUpLoadQueueIng;
        self.parms = params;
        self.flowKey = @"";
        self.fileSuffix = @"png";
        self.uploadImage = image;
    }
    
    return self;
}

/**
 *
 *  @brief  字典重新组装
 *
 *  @param params 参数字典
 *
 *  @return
 */
- (NSDictionary *)getRequestParamsWith:(NSDictionary*)params
{
    NSMutableDictionary *paramsDic = nil;
    if (params)
    {
        paramsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    else
    {
        paramsDic = [NSMutableDictionary dictionary];
    }
    
    return paramsDic;
}

/**
 *  开始上传
 */
- (void)startUpload
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        
        self.fileData = UIImageJPEGRepresentation(self.uploadImage, 0.6);
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            //联网中
            _upLoadState = DevUpLoadReady;
            //
            if (_delegate && [_delegate respondsToSelector:@selector(upLoadSpriteConnectionIng:upLoadIdentifier:)])
            {
                [_delegate upLoadSpriteConnectionIng:self upLoadIdentifier:_upLoadIdentifier];
            }
            
            NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
            //根据url初始化request
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_upLoadUrl]
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:60];
            //分界线 --AaB03x
            NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
            //结束符 AaB03x--
            NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
            
            // 上传的数据
            NSData* uploadData = self.fileData;//_expectedData
            //http body的字符串
            NSMutableString *body=[[NSMutableString alloc]init];
            // 得到参数
            
            NSDictionary *paramsDic = [self getRequestParamsWith:_parms];
            //参数的集合的所有key的集合
            NSArray *keys= [paramsDic allKeys];
            //poststring
            NSMutableString *postStrings = [NSMutableString string];
            //遍历keys
            for(int i=0;i<[keys count];i++)
            {
                //得到当前key
                NSString *key=[keys objectAtIndex:i];
                //添加分界线，换行
                [body appendFormat:@"%@\r\n",MPboundary];
                //添加字段名称，换2行
                [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
                //添加字段的值
                [body appendFormat:@"%@\r\n",[paramsDic objectForKey:key]];
                
                //--------以下只是为了拼接看完整的url ------
                NSString *value = [NSString stringWithFormat:@"%@",paramsDic[keys[i]]];
                NSString *encodedValue = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                                              (CFStringRef)value, nil,
                                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
                
                [postStrings appendFormat:@"%@=%@", keys[i], encodedValue];
                if (i != [keys count]-1)
                {
                    [postStrings appendFormat:@"&"];
                }
                //--------以上只是为了拼接看完整的url ------
                
            }
            NSLog(@"requestUrl====%@?%@",self.upLoadUrl,postStrings);

            if(uploadData)
            {
                ////添加分界线，换行
                [body appendFormat:@"%@\r\n",MPboundary];
                [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"fileinfo", [NSString stringWithFormat:@"file.%@",_fileSuffix]];
                //声明上传文件的格式
                [body appendFormat:@"Content-Type: %@\r\n\r\n", @"image/jpge"];
            }
            
            //声明结束符：--AaB03x--
            NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
            //声明myRequestData，用来放入http body
            NSMutableData *myRequestData=[NSMutableData data];
            
            //将body字符串转化为UTF8格式的二进制
            NSData *bodyHead = [body dataUsingEncoding:NSUTF8StringEncoding];
            //记录下长度
            _bodyHeadSize = bodyHead.length;
            
            [myRequestData appendData:bodyHead];
            
            if(uploadData)
            {
                //将image的data加入
                [myRequestData appendData:uploadData];
            }
            //加入结束符--AaB03x--
            NSData *endData = [end dataUsingEncoding:NSUTF8StringEncoding];
            //记录长度
            _bodyEndSize = endData.length;
            [myRequestData appendData:endData];
            //body总的大小
            _bodyTotalSize = myRequestData.length;
            //设置http body
            [request setHTTPBody:myRequestData];
            
            //设置HTTPHeader中Content-Type的值
            NSString *content=[[NSString alloc] initWithFormat:@"multipart/form-data; boundary=%@", TWITTERFON_FORM_BOUNDARY];
            //设置HTTPHeader
            [request setValue:content forHTTPHeaderField:@"Content-Type"];
            //设置Content-Length
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"Version:ios-1.0;" forHTTPHeaderField:@"User-Agent"];
            //http method
            [request setHTTPMethod:@"POST"];
            //构建NSURLConnection对象，并设置委托
            NSLog(@"request====%@",request);
            
            _urlconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
            [_urlconnection start];
        });
        
    });
    

}

/**
 *  停止上传
 */
- (void)stopUpload
{
    //上传暂停
    _upLoadState = DevUpLoadPause;
    [_urlconnection cancel];
}

#pragma -mark

//系统方法，接收数据时响应（反复调用）
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (nil == _responseData)
    {
        _responseData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [_responseData appendData:data];
    }    
}

//系统方法，连接失败的处理
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //上传失败
    NSLog(@"didFailWithError_im上传失败===%@",[error description]);
    _upLoadState = DevUpLoadFail;
    [_urlconnection cancel];
    
    if (_delegate && [_delegate respondsToSelector:@selector(upLoadSpriteConnection:didFailWithError:upLoadIdentifier:)])
    {
        [_delegate upLoadSpriteConnection:self didFailWithError:error upLoadIdentifier:_upLoadIdentifier];
    }
}

#pragma mark 每发送一段数据给服务器，就会调用这个方法。这个方法可以用来监听文件上传进度
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{

    CGFloat currentProgress = ((_bytesSended + totalBytesWritten )*1.0) / (totalBytesExpectedToWrite + _bytesSended);
//    NSLog(@"上传进度==%f",currentProgress);
    unsigned long haveSendLength = 0;
    
    if (totalBytesWritten + _bytesSended > _bodyHeadSize && (totalBytesWritten + _bytesSended) <= _bodyTotalSize - _bodyEndSize)
    {
        haveSendLength = totalBytesWritten + _bytesSended - _bodyHeadSize;
    }else if (totalBytesWritten + _bytesSended <= _bodyHeadSize)
    {
        haveSendLength = 0;
    }else if ((totalBytesWritten + _bytesSended) > _bodyTotalSize - _bodyEndSize)
    {
        haveSendLength = _totalSize;

    }
    if (_delegate && [_delegate respondsToSelector:@selector(upLoadSpriteConnection:didReceiveProgress:upLoadIdentifier:byteSend:totalSize:)])
    {
        [_delegate upLoadSpriteConnection:self didReceiveProgress:currentProgress upLoadIdentifier:_upLoadIdentifier byteSend:haveSendLength totalSize:totalBytesExpectedToWrite + _bytesSended];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(upLoadSpriteConnection:didReceiveProgress:upLoadIdentifier:)])
    {
        [_delegate upLoadSpriteConnection:self didReceiveProgress:currentProgress upLoadIdentifier:_upLoadIdentifier];
    }
    //邮件发送专用
    if (_delegate && [_delegate respondsToSelector:@selector(upLoadSpriteConnection:upLoadIdentifier:byteSend:)])
    {
        [_delegate upLoadSpriteConnection:self upLoadIdentifier:_upLoadIdentifier byteSend:bytesWritten];
    }
}

//系统方法，连接完成时处理
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"上传结束==response===%@",responseStr);

    //上传成功
    _upLoadState = DevUpLoadSuccess;
    [_urlconnection cancel];
    
    if (_delegate && [_delegate respondsToSelector:@selector(upLoadSpriteConnectionDidFinishLoading:upLoadIdentifier:response:)])
    {
        [_delegate upLoadSpriteConnectionDidFinishLoading:self upLoadIdentifier:_upLoadIdentifier response:responseStr];
    }
    _responseData = nil;
}

@end
