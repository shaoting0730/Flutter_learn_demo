//
//  JHRefreshBaseView.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-12.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "JHRefreshBaseView.h"
#import "JHRefreshConfig.h"
#import "UIScrollView+JHExtension.h"
#import "UIView+JHExtension.h"

@interface JHRefreshBaseView ()
@property (nonatomic, assign)       JHRefreshResult    refreshResult; //刷新是否成功

/**
 *  正在刷新时设置contentInset的值，header设置Top，footer设置bottom
 */
- (void)setRefreshingContentInset;
/**
 *  刷新完成后还原contentInset的值
 */
- (void)resumeContentInset;
@end

@implementation JHRefreshBaseView

+ (instancetype)createView
{
    return [[[self class] alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = JHRefreshViewHeight;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        self.state = JHRefreshStateNormal;
        
    }
    return self;
}

- (void)setAniView:(JHRefreshAniBaseView<JHRefreshViewDelegate> *)aniView
{
    if(_aniView)
    {
        [_aniView removeFromSuperview];
    }
    
    [self addSubview:aniView];
    _aniView = aniView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.jh_width = newSuperview.jh_width;
    
    [self.superview removeObserver:self forKeyPath:JHRefreshContentOffset];
    
    [newSuperview addObserver:self forKeyPath:JHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    
    _scrollView = (UIScrollView *)newSuperview;
    
}

- (BOOL)refreshing
{
    return self.state == JHRefreshStateRefreshing;
}

- (void)setState:(JHRefreshState)state
{
    //状态不改变什么都不做
    if(_state == state)
        return;
    
    JHRefreshState oldState = _state;
    _state = state;
    
    switch (oldState) {
        case JHRefreshStateNormal:
        {
            if(state == JHRefreshStatePulling)
            {
                //普通状态转为下拉状态
                [_aniView refreshViewAniToBePulling];
            }
        }
            break;
        case JHRefreshStateRefreshing:
        {
            if(state == JHRefreshStateNormal)
            {
                //刷新状态转为普通状态
                [_aniView refreshViewEndRefreshing:_refreshResult];
                
                switch (_refreshResult) {
                    case JHRefreshResultNone:
                    {
                        [self resumeContentInset];
                        [_aniView refreshViewAniToBeNormal];
                    }
                        break;
                    case JHRefreshResultSuccess:
                    case JHRefreshResultFailure:
                    {
                        //展示刷新结果，延时隐藏refreshView;
                        dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, JHRefreshShowResultAnimationDuration * NSEC_PER_SEC);
                        //延期执行
                        dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
                            [UIView animateWithDuration:JHRefreshSlowAnimationDuration animations:^{
                                [self resumeContentInset];
                                [_aniView refreshViewAniToBeNormal];
                            }];
                        });
                    }
                        break;
                }
            }
        }
            break;
        case JHRefreshStatePulling:
        {
            if(state == JHRefreshStateNormal)
            {
                //下拉状态转为普通状态
                [_aniView refreshViewAniToBeNormal];
            }
            else if(state == JHRefreshStateRefreshing)
            {
                //下拉状态转为刷新状态
                
                //
                [self setRefreshingContentInset];
                
                [_aniView refreshViewBeginRefreshing];
                
                //执行刷新block
                if(self.beginRefreshingBlock)
                    self.beginRefreshingBlock();
            }
        }
            break;
    }
}

- (void)endRefreshingWithResult:(JHRefreshResult)result
{
    self.refreshResult = result;
    self.state = JHRefreshStateNormal;
}

- (void)setRefreshingContentInset
{

}

- (void)resumeContentInset
{
    
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
