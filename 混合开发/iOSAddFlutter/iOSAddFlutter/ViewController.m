//
//  ViewController.m
//  iOSAddFlutter
//
//  Created by Shaoting Zhou on 2019/5/29.
//  Copyright © 2019 Shaoting Zhou. All rights reserved.
//

#import "ViewController.h"


#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"跳至Flutter模块" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor redColor];
    button.frame = CGRectMake(50, 50, 200, 100);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonPrint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}

- (void)buttonPrint{
    FlutterViewController * flutterVC = [[FlutterViewController alloc]init];
    [flutterVC setInitialRoute:@"我是Native传给FLutter模块的"];
    [self presentViewController:flutterVC animated:true completion:nil];
}



@end
