//
//  LSLoadMoreLoadingView.h
//  IOSDeveloperKit
//
//  Created by LoaforSpring on 16/5/18.
//  Copyright © 2016年 LoaforSpring. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSLoadMoreLoadingProtocol.h"

/**
 *  LoadingView的默认类  ->  也作为自定义loadingView初始化参考类
 */
@interface LSLoadMoreLoadingView : UIView
<LSLoadMoreLoadingProtocol>

@end

