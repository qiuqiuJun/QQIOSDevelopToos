//
//  IZCShowBigImage.m
//  DevTongXie
//
//  Created by Devstore on 15/7/3.
//  Copyright (c) 2015年 LoaforSpring. All rights reserved.
//

#import "IZCShowBigImage.h"
#import "QQDefine.h"

static CGRect oldframe;
@implementation IZCShowBigImage

- (void)dealloc
{
    
}

+(void)showImageWithButton:(UIButton *)aButton
{
    UIImage *image=[aButton imageForState:UIControlStateNormal];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kHLScreenFrameWidth, kHLScreenFrameHeight)];
    oldframe=[aButton convertRect:aButton.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,(kHLScreenFrameHeight-image.size.height*kHLScreenFrameWidth/image.size.width)/2, kHLScreenFrameWidth, image.size.height*kHLScreenFrameWidth/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];

}

+(void)showImage:(UIImageView *)showImage{
    
    UIImage *image=showImage.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kHLScreenFrameWidth, kHLScreenFrameHeight)];
    oldframe=[showImage convertRect:showImage.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,(kHLScreenFrameHeight-image.size.height*kHLScreenFrameWidth/image.size.width)/2, kHLScreenFrameWidth, image.size.height*kHLScreenFrameWidth/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
