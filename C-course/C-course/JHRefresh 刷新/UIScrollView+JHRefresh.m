//
//  UIScrollView+JHRefresh.m
//  JHRefresh
//
//  Created by Jiahai on 14-9-15.
//  Copyright (c) 2014年 Jiahai. All rights reserved.
//

#import "UIScrollView+JHRefresh.h"
#import "JHRefreshHeaderView.h"
#import "JHRefreshFooterView.h"
#import "AnimationView/JHRefreshCommonAniView.h"
#import "AnimationView/JHRefreshAmazingAniView.h"
#import "objc/runtime.h"

@interface UIScrollView()
@property (nonatomic, weak) JHRefreshHeaderView *header;
@property (nonatomic, weak) JHRefreshFooterView *footer;
@end

@implementation UIScrollView (JHRefresh)

#pragma mark - 关联属性
static char JHRefreshHeaderViewKey;
static char JHRefreshFooterViewKey;

- (void)setHeader:(JHRefreshHeaderView *)header {
    [self willChangeValueForKey:@"JHRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &JHRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"JHRefreshHeaderViewKey"];
}

- (JHRefreshHeaderView *)header {
    return objc_getAssociatedObject(self, &JHRefreshHeaderViewKey);
}

- (void)setFooter:(JHRefreshFooterView *)footer {
    [self willChangeValueForKey:@"JHRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &JHRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"JHRefreshFooterViewKey"];
}

- (JHRefreshFooterView *)footer {
    return objc_getAssociatedObject(self, &JHRefreshFooterViewKey);
}

#pragma mark -
- (void)addRefreshHeaderViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh
{
    assert([aniViewClass isSubclassOfClass:[JHRefreshAniBaseView class]]);
    
    if(!self.header)
    {
        JHRefreshHeaderView *headerView = [JHRefreshHeaderView createView];
        headerView.beginRefreshingBlock = beginRefresh;
        [self addSubview:headerView];
        self.header = headerView;
        headerView.aniView = [[aniViewClass alloc] init];
    }
}

- (void)addRefreshFooterViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh
{
    assert([aniViewClass isSubclassOfClass:[JHRefreshAniBaseView class]]);
    
    if(!self.footer)
    {
        JHRefreshFooterView *footerView = [JHRefreshFooterView createView];
        footerView.beginRefreshingBlock = beginRefresh;
        [self addSubview:footerView];
        self.footer = footerView;
        footerView.aniView = [[aniViewClass alloc] init];
    }
}

- (void)headerEndRefreshingWithResult:(JHRefreshResult)result
{
    [self.header endRefreshingWithResult:result];
}

- (void)footerEndRefreshing
{
    [self.footer endRefreshingWithResult:JHRefreshResultNone];
}
@end
