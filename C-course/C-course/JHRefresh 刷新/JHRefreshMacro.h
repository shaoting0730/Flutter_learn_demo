//
//  JHRefreshMacro.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-12.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#ifndef JHRefresh_JHRefreshMacro_h
#define JHRefresh_JHRefreshMacro_h


#pragma mark - 通用
#ifdef DEBUG
#define JHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JHLog(fmt, ...)
#endif

#define JHRefreshBundleName @"JHRefresh.bundle"
#define JHRefreshSrcName(file) ([JHRefreshBundleName stringByAppendingPathComponent:(file)])


#pragma mark  颜色配置
#define JHRGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#endif
