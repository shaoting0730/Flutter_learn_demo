//
//  UIScrollView+JHExtension.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JHExtension)
@property (nonatomic, assign)   CGFloat jh_contentInsetTop;
@property (nonatomic, assign)   CGFloat jh_contentInsetBottom;
@property (nonatomic, assign)   CGFloat jh_contentInsetLeft;
@property (nonatomic, assign)   CGFloat jh_contentInsetRight;

@property (nonatomic, assign)   CGFloat jh_contentSizeWidth;
@property (nonatomic, assign)   CGFloat jh_contentSizeHeight;
@end
