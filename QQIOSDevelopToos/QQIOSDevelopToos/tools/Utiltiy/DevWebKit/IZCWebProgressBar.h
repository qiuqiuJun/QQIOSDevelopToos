//
//  IZCWebProgressBar.h
//  iClapDemo
//
//  Created by LoaforSpring on 16/4/5.
//  Copyright © 2016年 iClap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IZCWebProgressBar : UIView

@property(nonatomic, strong) UIColor *progressColor;
@property(nonatomic) float progress;

- (void)setProgress:(CGFloat)value animated:(BOOL)animated;

@end
