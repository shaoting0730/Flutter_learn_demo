//
//  JHRefreshBaseView.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-12.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRefreshAniBaseView.h"

typedef NS_ENUM(NSInteger, JHRefreshState) {
    JHRefreshStatePulling       = 1,
    JHRefreshStateNormal,
    JHRefreshStateRefreshing
};

@interface JHRefreshBaseView : UIView
/**
 *  App中有多个refreshView时，用以存放不同的配置信息，如：lastUpdateTime，也可不填
 */
@property (nonatomic, assign)       NSInteger   ID;

@property (nonatomic, weak, readonly)       UIScrollView *scrollView;

@property (nonatomic, assign)       JHRefreshState  state;

@property (nonatomic, copy)     void (^beginRefreshingBlock)();

@property (nonatomic, strong)   JHRefreshAniBaseView<JHRefreshViewDelegate>     *aniView;
//@property (nonatomic, copy)     void (^)

@property (nonatomic, readonly)     BOOL    refreshing;

+ (instancetype)createView;

- (void)endRefreshingWithResult:(JHRefreshResult)result;
@end
