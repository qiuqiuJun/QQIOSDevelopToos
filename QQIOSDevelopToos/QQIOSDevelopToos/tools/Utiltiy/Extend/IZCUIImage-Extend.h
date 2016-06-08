//
//  IZCUIImage-Extend.h
//  DevTongXie
//
//  Created by LoaforSpring on 15/5/16.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IZCUIImage_Extend : NSObject

@end


@interface UIImage (DevUIImageExtend)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

+ (UIImage*)convertViewToImage:(UIView*)v;

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

// 修正图片的旋转
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;
// 缩放图片
- (UIImage *)scaleImageTo:(float)scaleSize;
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

// 裁剪图片---不要再用了。内存消耗太厉害。
- (UIImage *)imageAtRect:(CGRect)rect;

//裁剪图片
- (UIImage *)createThumbnailImageInRect:(CGRect)thumbnailRect;

- (UIImage *)imageSize:(CGSize)imageSize thumbnailRect:(CGRect)thumbnailRect;

//压缩图片为固定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
#pragma mark -  (Resize)
- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

- (UIImage *)fixOrientation;

- (UIImage *)rotatedByDegrees:(CGFloat)degrees;

@end
