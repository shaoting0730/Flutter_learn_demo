//
//  JHRefreshAniBaseView.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRefreshViewDelegate.h"
#import "JHRefreshConfig.h"

@interface JHRefreshAniBaseView : UIView<JHRefreshViewDelegate>
@property (nonatomic, assign)   JHRefreshViewType   refreshViewType;
@property (nonatomic, assign)   NSInteger           refreshViewID;

@end
