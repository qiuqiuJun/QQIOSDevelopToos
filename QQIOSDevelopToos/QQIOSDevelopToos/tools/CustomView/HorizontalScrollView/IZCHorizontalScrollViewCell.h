//
//  IZCHorizontalScrollViewCell.h
//  MSJ_HD
//
//  Created by Pro on 13-2-22.
//  Copyright (c) 2013年 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IZCHorizontalScrollViewCell : UIView

@property(nonatomic, assign) NSInteger cellIndex;
@property(nonatomic, strong) NSString *reuseIdentifier;

- (NSString*)reuseIdentifier;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString*) identifier;
- (void)prepareForReuse;
- (void)fillViewWithObject:(id)object;

@end