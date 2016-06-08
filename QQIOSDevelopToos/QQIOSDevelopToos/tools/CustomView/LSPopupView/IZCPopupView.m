//
//  IZCPopupView.m
//  iZichanTask
//
//  Created by quanqi on 16/6/1.
//  Copyright © 2016年 iZichan. All rights reserved.
//

#import "IZCPopupView.h"
#import "QQDefine.h"

@implementation IZCPopupView
- (id)initWithContentV:(UIView *)contentView contentSize:(CGSize)size
{
    self = [super initWithContentView:contentView contentSize:size];
    if (self)
    {
        self.popupViewColor = [UIColor whiteColor];
        self.shadowColor = DevGetColorFromHex(0xdddddd);
        self.shadowOffset = CGSizeMake(10, 10);
        self.contentOffset = CGSizeMake(2, 2);
        self.arrowSize = CGSizeMake(18, 10);
        self.popupViewRadius = 3.0;
        self.overlayViewColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    }
    return self;
}
@end
