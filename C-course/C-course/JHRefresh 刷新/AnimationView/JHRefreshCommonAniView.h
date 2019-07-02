//
//  JHRefreshCommonAniView.h
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRefreshMacro.h"
#import "JHRefreshAniBaseView.h"

@interface JHRefreshCommonAniView : JHRefreshAniBaseView
{
    UIImageView     *_arrowImgView;
    UIActivityIndicatorView *_activityView;
    UILabel         *_statusLabel;
    UILabel         *_lastUpdateTimeLabel;
}
@end
