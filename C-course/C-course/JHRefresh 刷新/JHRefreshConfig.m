//
//  JHRefreshConfig.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-12.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "JHRefreshConfig.h"

const CGFloat JHRefreshViewHeight = 60.0;
const CGFloat JHRefreshFastAnimationDuration = 0.2;
const CGFloat JHRefreshSlowAnimationDuration = 0.4;
const CGFloat JHRefreshShowResultAnimationDuration = 0.8;


NSString *const JHRefreshContentOffset = @"contentOffset";
NSString *const JHRefreshContentSize = @"contentSize";

NSString *const JHRefreshConfigKey = @"JHRefreshConfig";
NSString *const JHRefreshLastUpdateTimeKey = @"JHRefreshLastUpdateTime";
NSString *const JHRefreshLastUpdateTimeFormat = @"yyyy-MM-dd HH:mm";

/**
 *  JHRefreshConfig的目录结构
    --NSUserDefaults
      |
       ——JHRefreshConfigKey             //JHRefresh所有的配置存储路径
         |
         |——JHRefreshLastUpdateTimeKey  //lastUpdateTime配置存储路径
 */

@implementation JHRefreshConfig

+ (NSString*)nowTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:JHRefreshLastUpdateTimeFormat];
    return [NSString stringWithFormat:@"上次刷新：%@", [dateFormatter stringFromDate:[NSDate date]]];
}

+ (NSString *)getLastUpdateTimeWithRefreshViewID:(NSInteger)ID
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *refreshDic = [userDefault objectForKey:JHRefreshConfigKey];
    NSString *time = [[refreshDic objectForKey:JHRefreshLastUpdateTimeKey] objectForKey:[NSString stringWithFormat:@"%@_%d",JHRefreshLastUpdateTimeKey,ID]];
    
    if(!time)
    {
        return [[self class] nowTimeString];
    }
    
    return time;
}

+ (void)updateLastUpdateTimeWithRefreshViewID:(NSInteger)ID
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *refreshDic = [userDefault objectForKey:JHRefreshConfigKey];
    if(!refreshDic)
    {
        refreshDic = [NSMutableDictionary dictionary];
    }
    NSMutableDictionary *lastUpdateTimeDic = [refreshDic objectForKey:JHRefreshLastUpdateTimeKey];
    if(!lastUpdateTimeDic)
    {
        lastUpdateTimeDic = [NSMutableDictionary dictionary];
    }
    [lastUpdateTimeDic setObject:[[self class] nowTimeString] forKey:[NSString stringWithFormat:@"%@_%d",JHRefreshLastUpdateTimeKey,ID]];
    
    [userDefault setObject:refreshDic forKey:JHRefreshConfigKey];
    [userDefault synchronize];
}

@end