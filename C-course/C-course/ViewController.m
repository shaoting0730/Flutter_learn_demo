//
//  ViewController.m
//  C-course
//
//  Created by mac on 16/6/11.
//  Copyright © 2016年 mac. All rights reserved.
//



#import "ViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "JHRefresh.h"
#import "webC.h"
#import "ZhangjieModel.h"
#import "FenZuModel.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
    NSArray * _group;
    UITableView *_tableView;
}


@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc]init];
    _group = [[NSMutableArray alloc]init];
    _data= @[@{@"groupTitle":@"缘起",
               @"subArr":@[
                       @"Flutter 完全手册大纲",
                       @"Flutter 基础篇",@"移动端跨平台开发方案的演进",@"搭建Flutter环境",@"创建第一个 Flutter APP",@"Flutter 开发利器 —— Hot Reload",
                       @"Dart 简介及基础语法",@"Flutter 的基础 —— Widget",@"StatefulWidget 及 State", @"StatelessWidget",
                       @"MaterialApp 与 Scaffold",@"Flutter 写 UI 的方式 —— 声明式",@"Widget 的深度理解",@"Flutter 基础 Widget —— 文本框",@"Flutter 基础 Widget —— 图片和Icon",@"Flutter 基础 Widget —— 输入框",@"Flutter 基础 Widget —— 对话框",
                       @"Flutter 基础 Widget —— SnackBar 和 Builder 的使用",@"Flutter 基础 Widget —— 对话框",@"Flutter 基础 Widget —— BottomSheet",@"Flutter 基础Widget —— 菜单按钮",@"Flutter 手势识别 Widget",@"Flutter 布局 —— 理解 BoxConstraint（盒约束）布局模型",@"Flutter 布局 Widget",@"Flutter 布局 Widget —— 弹性布局",
                       @"Flutter布局Widget —— 线性布局",@"Flutter 布局 Widget —— 流式布局",@"Flutter 布局 Widget —— 层叠布局",@"Flutter 容器类 Widget",@"Flutte 可滚动 Widget",@"Flutter 可滚动Widget —— SingleChildScrollView",@"Flutter 可滚动Widget —— ListView",@"Flutter 可滚动Widget -- CustomScrollView",
                       @"Flutter 可滚动 Widget —— GridView",@"Flutter 可滚动 Widget —— PageView",@"Flutter 功能类 Widget",@"Flutter 实战篇：仿豆瓣电影APP",@"信息流 ListView 的实现",@"数据请求的实现",@"Flutter 异步编程",
                       @"城市选择页面实现",@"Flutter 路由：Route",@"存取本地数据",@"声明式UI 的编程思维",@"实现买票的功能",@"Flutter 与 Native 通信：PlatformChannel",@"Flutter 性能监控工具",@"Flutter APP 的打包",
                       @"Flutter 开发进阶篇",@"Flutter UI 渲染过程 —— Widget，Element，RenderObject",@"Flutter 的状态管理",@"Flutter Isolate",@"Flutter 底层进阶篇",@"Flutter 架构深度解析",@"了解 Flutter 的 Thread Model（线程模型）",@"Flutter 的 Event Loop(事件循环)及代码运行顺序",
                       
                       ]},
             

];
//
    self.navigationItem.title = @"Flutter 完全手册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    [self createTableView];
    
}



#pragma mark - 创建表格视图

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _data[section][@"subArr"];
    return arr.count;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return _data[section][@"groupTitle"];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",@(indexPath.row+1), _data[indexPath.section][@"subArr"][indexPath.row]];
   
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 30;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebC *web = [[WebC alloc]init];
    web.title = _data[0][@"subArr"][indexPath.row];
    web.url = [NSString stringWithFormat:@"%d",indexPath.row+1];
    [self.navigationController pushViewController:web animated:NO];
}

@end
