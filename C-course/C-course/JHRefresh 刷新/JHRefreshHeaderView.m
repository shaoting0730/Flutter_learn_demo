//
//  JHRefreshHeaderView.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "JHRefreshHeaderView.h"
#import "JHRefreshConfig.h"
#import "UIScrollView+JHExtension.h"
#import "UIView+JHExtension.h"

@implementation JHRefreshHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.jh_originY = -JHRefreshViewHeight;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.state == JHRefreshStateRefreshing)
        return;
    
    if([keyPath isEqualToString:JHRefreshContentOffset])
    {
        [self changeStateWithContentOffset];
        
        if([self.aniView respondsToSelector:@selector(refreshViewPullingToPosition:)])
        {
            NSInteger pos = self.scrollView.contentOffset.y;
            
            //headerView不可见/全部可见时，直接返回
            if(pos > 0 || pos < -JHRefreshViewHeight-self.scrollView.jh_contentInsetTop)
                return;
            
            [self.aniView refreshViewPullingToPosition:abs((int)pos)-self.scrollView.jh_contentInsetTop];
        }
    }
}

- (void)changeStateWithContentOffset
{
    CGFloat currentOffsetY = self.scrollView.contentOffset.y;
    CGFloat releaseToRefreshOffsetY = - self.scrollView.jh_contentInsetTop;
    
    //headerView的顶端不可见时，直接返回
    if(currentOffsetY>=releaseToRefreshOffsetY)
        return;
    
    releaseToRefreshOffsetY -= self.jh_height;
    
    if(self.scrollView.isDragging)
    {
        if(self.state == JHRefreshStateNormal && currentOffsetY < releaseToRefreshOffsetY)
        {
            //即将刷新
            self.state = JHRefreshStatePulling;
        }
        else if(self.state == JHRefreshStatePulling && currentOffsetY>=releaseToRefreshOffsetY)
        {
            //普通状态
            self.state = JHRefreshStateNormal;
        }
    }
    else if (self.state == JHRefreshStatePulling)
    {
        //开始刷新
        self.state = JHRefreshStateRefreshing;
    }
}

- (void)setRefreshingContentInset
{
    self.scrollView.jh_contentInsetTop += JHRefreshViewHeight;
}

- (void)resumeContentInset
{
    self.scrollView.jh_contentInsetTop -= JHRefreshViewHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
