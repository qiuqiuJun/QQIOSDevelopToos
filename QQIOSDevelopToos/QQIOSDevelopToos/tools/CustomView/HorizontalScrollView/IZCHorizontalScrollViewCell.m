//
//  IZCHorizontalScrollViewCell.m
//  MSJ_HD
//
//  Created by Pro on 13-2-22.
//  Copyright (c) 2013年 Pro. All rights reserved.
//

#import "IZCHorizontalScrollViewCell.h"

@implementation IZCHorizontalScrollViewCell

@synthesize cellIndex = _cellIndex;

- (void)dealloc
{
    _reuseIdentifier = nil;
}

-(NSString *)reuseIdentifier
{
    if (nil == _reuseIdentifier)
    {
        _reuseIdentifier = [[self class] description];
    }

	return _reuseIdentifier;
}

-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString*) identifier
{
	if(self=[super initWithFrame:frame])
    {
		self.reuseIdentifier = identifier;
	}
	return self;
}

- (void)prepareForReuse{}
- (void)fillViewWithObject:(id)object{};

@end
