//
//  LSHorizontalScrollViewCell.h
//  MSJ_HD
//
//  Created by Pro on 13-2-22.
//  Copyright (c) 2013年 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSHorizontalScrollViewCell : UIView

@property(nonatomic, assign) NSInteger cellIndex;
@property(nonatomic, strong) NSString *reuseIdentifier;

- (NSString*)reuseIdentifier;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString*) identifier;

// 以下两个方法都是用来让子类继承的
/**
 *  准备重用，这个方法里面写一些释放的操作
 */
- (void)prepareForReuse;

/**
 *  填充数据
 *
 *  @param object 数据对象
 */
- (void)fillViewWithObject:(id)object;

@end