//
//  WebViewController.h
//  C-course
//
//  Created by mac on 16/6/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhangjieModel.h"

@interface WebC : UIViewController

@property(nonatomic,strong)ZhangjieModel *model;
@property(nonatomic,copy)NSString *url;
@end
