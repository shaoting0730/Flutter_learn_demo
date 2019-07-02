//
//  UIView+JHExtension.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "UIView+JHExtension.h"

@implementation UIView (JHExtension)
- (CGFloat)jh_originX
{
    return self.frame.origin.x;
}
- (void)setJh_originX:(CGFloat)jh_originX
{
    CGRect rect = self.frame;
    rect.origin.x = jh_originX;
    self.frame = rect;
}

- (CGFloat)jh_originY
{
    return self.frame.origin.y;
}
- (void)setJh_originY:(CGFloat)jh_originY
{
    CGRect rect = self.frame;
    rect.origin.y = jh_originY;
    self.frame = rect;
}

- (CGFloat)jh_width
{
    return self.frame.size.width;
}
- (void)setJh_width:(CGFloat)jh_width
{
    CGRect rect = self.frame;
    rect.size.width = jh_width;
    self.frame = rect;
}

- (CGFloat)jh_height
{
    return self.frame.size.height;
}
- (void)setJh_height:(CGFloat)jh_height
{
    CGRect rect = self.frame;
    rect.size.height = jh_height;
    self.frame = rect;
}

@end
