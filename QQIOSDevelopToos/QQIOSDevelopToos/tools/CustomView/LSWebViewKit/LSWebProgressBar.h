//
//  LSWebProgressBar.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/14.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSWebProgressBar : UIView

@property(nonatomic, strong) UIColor *progressColor;
@property(nonatomic) float progress;

- (void)setProgress:(CGFloat)value animated:(BOOL)animated;

@end
