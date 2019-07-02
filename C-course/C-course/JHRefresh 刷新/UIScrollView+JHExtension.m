//
//  UIScrollView+JHExtension.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "UIScrollView+JHExtension.h"

@implementation UIScrollView (JHExtension)
#pragma mark - contentInset
- (CGFloat)jh_contentInsetTop
{
    return self.contentInset.top;
}
- (void)setJh_contentInsetTop:(CGFloat)jh_contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = jh_contentInsetTop;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInsetBottom
{
    return self.contentInset.bottom;
}
- (void)setJh_contentInsetBottom:(CGFloat)jh_contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = jh_contentInsetBottom;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInsetLeft
{
    return self.contentInset.left;
}
- (void)setJh_contentInsetLeft:(CGFloat)jh_contentInsetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = jh_contentInsetLeft;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInsetRight
{
    return self.contentInset.right;
}
- (void)setJh_contentInsetRight:(CGFloat)jh_contentInsetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = jh_contentInsetRight;
    self.contentInset = inset;
}

#pragma mark - contentSize
- (CGFloat)jh_contentSizeWidth
{
    return self.contentSize.width;
}
- (void)setJh_contentSizeWidth:(CGFloat)jh_contentSizeWidth
{
    CGSize size = self.contentSize;
    size.width = jh_contentSizeWidth;
    self.contentSize = size;
}
- (CGFloat)jh_contentSizeHeight
{
    return self.contentSize.height;
}
- (void)setJh_contentSizeHeight:(CGFloat)jh_contentSizeHeight
{
    CGSize size = self.contentSize;
    size.height = jh_contentSizeHeight;
    self.contentSize = size;
}
@end
