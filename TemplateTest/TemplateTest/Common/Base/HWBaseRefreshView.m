//
//  HWBaseRefreshView.m
//  Template-OC
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGOViewCommon.h"
#import "EmptyControl.h"

@interface HWBaseRefreshView() < EGORefreshTableDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) EGORefreshTableFooterView * refreshFooterView;
@property (nonatomic, strong) EGORefreshTableHeaderView * refreshHeadView;
@property (nonatomic, strong) UIView                    * endView;
@property (nonatomic, assign) EGORefreshPos             pulldownState;

@end

@implementation HWBaseRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isLastPage = YES;
        self.backgroundColor = COLOR_F3F3F3;
        [self addSubview:self.baseTable];
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.baseTable addSubview:self.refreshHeadView];
        [self.baseTable addSubview:self.refreshFooterView];
        self.currentPage = 1;
    }
    return self;
}
- (instancetype)initWithGroupFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isLastPage = YES;
        self.backgroundColor = COLOR_F3F3F3;
        [self addSubview:self.baseTableGroup];
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.baseTable addSubview:self.refreshHeadView];
        [self.baseTable addSubview:self.refreshFooterView];
        self.currentPage = 1;
    }
    return self;
}

#pragma mark - 初始化视图

- (UITableView *)baseTable
{
    if (_baseTable == nil)
    {
        _baseTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.backgroundColor = [UIColor clearColor];
        _baseTable.backgroundView = nil;
        [_baseTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseTable.showsVerticalScrollIndicator = NO;
    }
    return _baseTable;
}
- (UITableView *)baseTableGroup
{
    if (_baseTable == nil)
    {
        _baseTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.backgroundColor = [UIColor clearColor];
        _baseTable.backgroundView = nil;
        [_baseTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseTable.showsVerticalScrollIndicator = NO;
    }
    return _baseTable;
}


- (EGORefreshTableHeaderView *)refreshHeadView
{
    if (_refreshHeadView == nil)
    {
        _refreshHeadView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.bounds.size.height, self.frame.size.width, self.bounds.size.height) arrowImageName:nil textColor:[UIColor redColor]];
    }
    _refreshHeadView.delegate = self;
    [_refreshHeadView refreshLastUpdatedDate];
    return _refreshHeadView;
}

- (EGORefreshTableFooterView *)refreshFooterView
{
    CGFloat height = MAX(self.baseTable.contentSize.height, self.baseTable.frame.size.height);
    CGRect footerFrame = CGRectMake(0, height, self.baseTable.frame.size.width, self.bounds.size.height);
    
    if (_refreshFooterView == nil)
    {
        _refreshFooterView = [[EGORefreshTableFooterView alloc]initWithFrame:footerFrame];
        _refreshFooterView.backgroundColor = [UIColor clearColor];
        _refreshFooterView.delegate = self;
    }
    else
    {
        _refreshFooterView.frame = footerFrame;
    }
    
    if (self.isLastPage)
    {
        _refreshFooterView.hidden = YES;
    }
    else
    {
        _refreshFooterView.hidden = NO;
    }
    
    [_refreshFooterView refreshLastUpdatedDate];

    return _refreshFooterView;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isNeedHeadRefresh)
    {
        [self.refreshHeadView egoRefreshScrollViewDidBeginScroll:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isNeedHeadRefresh)
    {
        [self.refreshHeadView egoRefreshScrollViewDidScroll:scrollView];
    }
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isNeedHeadRefresh)
    {
        [self.refreshHeadView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    if (!self.isHeadLoading && !self.isLastPage)
    {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];;
    }


}


#pragma mark - EGORefreshTableHeaderDelegate Methods

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view
{
    return self.isHeadLoading;
}

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{

    [self beginToReloadData:aRefreshPos];
    
}

- (void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
    self.isHeadLoading = YES;
    if (aRefreshPos == EGORefreshHeader)
    {
        self.currentPage = 1;
    }
    else if (aRefreshPos == EGORefreshFooter && !self.isLastPage)
    {
        self.currentPage++;
    }
    [self reloadTableViewDataSource];

}

#pragma mark - 数据源

- (NSMutableArray *)baseListArr
{
    if (_baseListArr == nil)
    {
        _baseListArr = [[NSMutableArray alloc]init];
    }
    return _baseListArr;
}

#pragma mark - function

- (void)doneLoadingTableViewData
{
    [self finishedLoadData];
//    [self refreshFooterView];
}
- (void)queryListData
{
    if (self.observer) {
        [self.observer sendAction:NSStringFromSelector(@selector(queryListData))];
    } else {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:5];
    }
    
}


//主动调用下拉刷新

- (void)refreshData
{
    if (self.isNeedHeadRefresh)
    {
        [self queryListData];
    }

}

- (NSDate *)egoRefreshTableDataSourceLastUpdated:(UIView *)view
{
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    return date;
    
}

- (void)finishedLoadData
{
    self.isHeadLoading = NO;
    [self.refreshHeadView egoRefreshScrollViewDataSourceDidFinishedLoading:self.baseTable];
    
    [self refreshFooterView];
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.baseTable];
}

- (void)reloadTableViewDataSource
{
    self.isHeadLoading = YES;
    [self queryListData];
}

#pragma mark - set方法

- (void)setIsNeedHeadRefresh:(BOOL)isNeedHeadRefresh
{
    _isNeedHeadRefresh = isNeedHeadRefresh;
    if (_isNeedHeadRefresh) {
        self.refreshHeadView.hidden = NO;
    }
    else
    {
        self.refreshHeadView.hidden = YES;
    }

}

#pragma mark - tableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.footerHeight == nil) {
        return 0.000001;
    }
    return self.footerHeight(section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.headerHeight == nil) {
        return 0.000001;
    }
    return self.headerHeight(section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellHeight==nil) {
        return 45;
    }
    return self.cellHeight(indexPath);
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.headerView) {
        return self.headerView(section);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelected) {
        self.didSelected(indexPath);
    }
}

#pragma mark - showEmptyView

- (void)showEmptyView:(NSString *)message
{
    if([self viewWithTag:111222] != nil)
    {
        [[self viewWithTag:111222] removeFromSuperview];
    }
    
    __weak HWBaseRefreshView *weakSelf = self;
    EmptyControl * empty = [[EmptyControl alloc]initWithTitle:message frame:self.baseTable.bounds image:@"status_icon7" onClick:^{
        [weakSelf queryListData];
        
    }]; 
    empty.tag = 111222;
    [self addSubview:empty];
}

- (void)showEmptyView:(NSString *)message withImage:(NSString *)image
{
    if([self viewWithTag:111222] != nil)
    {
        [[self viewWithTag:111222] removeFromSuperview];
    }
    
    __weak HWBaseRefreshView *weakSelf = self;
    EmptyControl * empty = [[EmptyControl alloc]initWithTitle:message frame:self.baseTable.bounds image:image onClick:^{
        [weakSelf queryListData];
        
    }];
    empty.tag = 111222;
    [self addSubview:empty];
}

- (void)showEmptyFail:(NSString *)message
{
    if([self viewWithTag:111222] != nil)
    {
        [[self viewWithTag:111222] removeFromSuperview];
    }
    
    __weak HWBaseRefreshView *weakSelf = self;
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:message frame:self.baseTable.frame image:@"status_icon6" onClick:^{
        
        [weakSelf queryListData];
    }];
    empty.tag = 111222;
    [self addSubview:empty];
}

- (void)showEmpty:(NSString *)msg withOffset:(float)offset
{
    if([self viewWithTag:111222] != nil)
        return;
    __weak HWBaseRefreshView *weakSelf = self;
    
    CGRect frame = self.baseTable.frame;
    frame.origin.y = frame.origin.y + offset;
    frame.size.height = frame.size.height - offset;
    
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:msg frame:frame image:@"" onClick:^{
     
        [weakSelf queryListData];
    }];
    empty.tag = 111222;
    [self addSubview:empty];
}

- (void)hideEmptyView
{
    if ([self viewWithTag:111222])
    {
        [[self viewWithTag:111222] removeFromSuperview];
    }
}

- (void)dealloc
{

    [NSObject cancelPreviousPerformRequestsWithTarget:self.refreshHeadView];
}

@end
