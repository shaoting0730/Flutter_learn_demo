//
//  JHRefreshFooterView.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-16.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "JHRefreshFooterView.h"
#import "JHRefreshConfig.h"
#import "UIView+JHExtension.h"
#import "UIScrollView+JHExtension.h"

@implementation JHRefreshFooterView

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
    
    [self.superview removeObserver:self forKeyPath:JHRefreshContentSize];
    
    [newSuperview addObserver:self forKeyPath:JHRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
    
    [self ajustFooterView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:JHRefreshContentSize])
    {
        [self ajustFooterView];
    }
    
    //正在刷新,直接返回
    if(self.state == JHRefreshStateRefreshing)
    {
        return;
    }
    if([keyPath isEqualToString:JHRefreshContentOffset])
    {
        [self changeStateWithContentOffset];
        
        if([self.aniView respondsToSelector:@selector(refreshViewPullingToPosition:)])
        {
            NSInteger pos = self.scrollView.contentOffset.y + self.scrollView.jh_height - self.scrollView.jh_contentSizeHeight-self.scrollView.jh_contentInsetBottom;
            
            //footerView不可见/全部显示后，直接返回
            if(pos <= 0 || pos > JHRefreshViewHeight)
                return;
            
            [self.aniView refreshViewPullingToPosition:pos];
        }
    }
}

- (void)changeStateWithContentOffset
{
    CGFloat currentOffsetY = self.scrollView.contentOffset.y;
    CGFloat releaseToRefreshOffsetY = self.scrollView.jh_contentSizeHeight - self.scrollView.jh_height + self.scrollView.jh_contentInsetBottom;
    
    //footerView的顶端不可见时，直接返回
    if(currentOffsetY <= releaseToRefreshOffsetY)
    {
        return;
    }
    
    releaseToRefreshOffsetY += JHRefreshViewHeight;
    
    if(self.scrollView.isDragging)
    {
        if(self.state == JHRefreshStateNormal && currentOffsetY>releaseToRefreshOffsetY)
        {
            self.state = JHRefreshStatePulling;
        }
        else if(self.state == JHRefreshStatePulling && currentOffsetY <= releaseToRefreshOffsetY)
        {
            self.state = JHRefreshStateNormal;
        }
    }
    else
    {
        if(self.state == JHRefreshStatePulling)
        {
            self.state = JHRefreshStateRefreshing;
        }
    }
}

/**
 *  调整footerView的位置
 */
- (void)ajustFooterView
{
    CGFloat contentSizeHeight = self.scrollView.jh_contentSizeHeight;
    CGFloat height = self.scrollView.jh_height;
    
    self.jh_originY = MAX(height, contentSizeHeight);
}

- (void)setRefreshingContentInset
{
    self.scrollView.jh_contentInsetBottom += JHRefreshViewHeight;
}

- (void)resumeContentInset
{
    self.scrollView.jh_contentInsetBottom -= JHRefreshViewHeight;
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
