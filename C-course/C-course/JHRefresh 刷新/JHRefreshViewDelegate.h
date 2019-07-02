//
//  JHRefreshViewDelegate.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHRefreshConfig.h"

@protocol JHRefreshViewDelegate <NSObject>

@required
/**
 *  下拉时的动画
 */
- (void)refreshViewAniToBePulling;
/**
 *  变成普通状态时的动画
 */
- (void)refreshViewAniToBeNormal;
/**
 *  刷新开始
 */
- (void)refreshViewBeginRefreshing;
/**
 *  刷新结束
 *
 *  @param result 刷新结果
 */
- (void)refreshViewEndRefreshing:(JHRefreshResult)result;

@optional
/**
 *  拖拽到对应的位置
 *
 *  @param pos 位置，范围：1-JHRefreshViewHeight
 */
- (void)refreshViewPullingToPosition:(NSInteger)pos;

@end
