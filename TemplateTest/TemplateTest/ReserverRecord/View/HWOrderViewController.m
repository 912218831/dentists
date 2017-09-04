//
//  HWOrderViewController.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/25.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//  预约记录

#import "HWOrderViewController.h"
#import "HWBaseRefreshView.h"
#import "JKRSearchController.h"
#import "JKRSearchResultViewController.h"
#import "ReserverRecordViewModel.h"
#import "ReserverRecordCell.h"

@interface HWOrderViewController () <JKRSearchBarDelegate,
                                    JKRSearchControllerDelegate,
                                    JKRSearchControllerhResultsUpdating,
                                    UITableViewDataSource>
@property (nonatomic, strong) HWBaseRefreshView *listView;
@property (nonatomic, strong) JKRSearchController *searchController;
@property (nonatomic, strong) ReserverRecordViewModel *viewModel;
@end

@implementation HWOrderViewController
@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /*为了解决隐藏导航栏，tableView 的 contentOffset 偏移的问题*/
    [[IQKeyboardManager sharedManager]setEnable:false];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager]setEnable:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)configContentView {
    [super configContentView];
    
    self.listView = [[HWBaseRefreshView alloc]initWithFrame:self.view.bounds];
    [self.contentView addSubview:self.listView];
    self.listView.cellHeight = ^(NSIndexPath *indexPath){
        return (CGFloat)kRate(122);
    };
    self.listView.baseTable.dataSource = self;
    
    JKRSearchResultViewController *resultSearchController = [[JKRSearchResultViewController alloc] init];
    self.searchController = [[JKRSearchController alloc] initWithSearchResultsController:resultSearchController];
    self.searchController.searchBar.placeholder = kReserverRecordSearchPlaceholder;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate = self;
    [self.listView.baseTable setTableHeaderView:self.searchController.searchBar];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;//self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"ReserverRecordCell";
    ReserverRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ReserverRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

#pragma mark - JKRSearchControllerhResultsUpdating
- (void)updateSearchResultsForSearchController:(JKRSearchController *)searchController {
    
}

#pragma mark - JKRSearchBarDelegate
- (void)searchBarTextDidBeginEditing:(JKRSearchBar *)searchBar {
    NSLog(@"searchBarTextDidBeginEditing %@", searchBar);
}

- (void)searchBarTextDidEndEditing:(JKRSearchBar *)searchBar {
    NSLog(@"searchBarTextDidEndEditing %@", searchBar);
}

- (void)searchBar:(JKRSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchBar:%@ textDidChange:%@", searchBar, searchText);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
