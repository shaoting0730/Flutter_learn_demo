#import "webC.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface WebC()<UIScrollViewDelegate,UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation WebC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWeb];
}

-(void) createWeb {
     self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _webView.scalesPageToFit = NO;
    _webView.scrollView.delegate = self;
   _webView.delegate = self;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.url ofType:@"html"];
    NSLog(@"=======%@",self.url);
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [_webView loadHTMLString:htmlString baseURL:url];
   
    [self.view addSubview: _webView];
    [self configNavigation];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x > 0) {
        scrollView.contentOffset = CGPointMake(0, point.y);//这里不要设置为CGPointMake(0, 0)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
    }
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    
    //判断是否是单击
    
//    if (navigationType == UIWebViewNavigationTypeLinkClicked)
//
//    {
//        NSURL *url = [request URL];
//        if([[UIApplication sharedApplication]canOpenURL:url])
//
//        {
//            return NO;
//        }
//    }
    return YES;
}

-(void)configNavigation
{

    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(0, 0, 15, 25);
    [leftButton setImage:[UIImage imageNamed:@"icons_back_white"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(dealSelect) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;

}


-(void)dealSelect
{
    if ([_webView canGoBack])
    {   // webView本身回退
        [_webView goBack];
    }
    else
    {   // 原生回退
         [self.navigationController popViewControllerAnimated:YES];
    }
   
}

@end
