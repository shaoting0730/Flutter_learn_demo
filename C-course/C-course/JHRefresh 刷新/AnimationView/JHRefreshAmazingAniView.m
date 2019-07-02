//
//  JHRefreshAmazingAniView.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-17.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "JHRefreshAmazingAniView.h"
#import "JHRefreshMacro.h"
#import "UIView+JHExtension.h"

@implementation JHRefreshAmazingAniView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _aniImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:JHRefreshSrcName(@"dropdown_anim__0001.png")]];
        _aniImgView.frame = CGRectMake(0, 0, 50, 50);
        _aniImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_aniImgView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _aniImgView.center = CGPointMake(self.jh_width*0.5, self.jh_height*0.5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - JHRefreshViewDelegate

/**
 *  下拉时的动画
 */
- (void)refreshViewAniToBePulling
{
    
}
/**
 *  变成普通状态时的动画
 */
- (void)refreshViewAniToBeNormal
{
    [_aniImgView stopAnimating];
}
/**
 *  刷新开始
 */
- (void)refreshViewBeginRefreshing
{
    if(!_aniImgView.animationImages)
    {
        _aniImgView.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:JHRefreshSrcName(@"dropdown_loading_01.png")],
                                       [UIImage imageNamed:JHRefreshSrcName(@"dropdown_loading_02.png")],
                                       [UIImage imageNamed:JHRefreshSrcName(@"dropdown_loading_03.png")],
                                       nil];
        _aniImgView.animationDuration = 0.6;
        _aniImgView.animationRepeatCount = 0;
    }
    [_aniImgView startAnimating];
}
/**
 *  刷新结束
 *
 *  @param result 刷新结果
 */
- (void)refreshViewEndRefreshing:(JHRefreshResult)result
{
    
}
/**
 *  拖拽到对应的位置
 *
 *  @param pos 位置，范围：1-JHRefreshViewHeight
 */
- (void)refreshViewPullingToPosition:(NSInteger)pos
{
    if(pos == 0)
    {
        return;
    }
    CGFloat x = 1;
    CGPoint center = _aniImgView.center;
    
    _aniImgView.jh_width = _aniImgView.jh_height = x*pos;
    
    _aniImgView.center = center;
    
    NSString *name = [NSString stringWithFormat:@"dropdown_anim__000%d.png",(int)pos];
    _aniImgView.image = [UIImage imageNamed:JHRefreshSrcName(name)];
    
}


@end
