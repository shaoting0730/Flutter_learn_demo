//
//  JHRefreshConfig.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-12.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "JHRefreshMacro.h"


typedef NS_ENUM(NSInteger, JHRefreshViewType) {
    JHRefreshViewTypeHeader     = 1,
    JHRefreshViewTypeFooter
};

/**
 *  刷新结果
 */
typedef NS_ENUM(NSInteger, JHRefreshResult) {
    /**
     *  不展示刷新结果，刷新结束直接隐藏
     */
    JHRefreshResultNone         = 0,
    /**
     *  展示刷新成功界面，延时隐藏
     */
    JHRefreshResultSuccess,
    /**
     *  展示刷新失败界面，延时隐藏
     */
    JHRefreshResultFailure
};



extern const CGFloat JHRefreshViewHeight;
extern const CGFloat JHRefreshFastAnimationDuration;
extern const CGFloat JHRefreshSlowAnimationDuration;
extern const CGFloat JHRefreshShowResultAnimationDuration;


extern NSString *const JHRefreshContentOffset;
extern NSString *const JHRefreshContentSize;

@interface JHRefreshConfig : NSObject

+ (NSString *)getLastUpdateTimeWithRefreshViewID:(NSInteger)ID;

+ (void)updateLastUpdateTimeWithRefreshViewID:(NSInteger)ID;

@end
