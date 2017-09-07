//
//  BaseListViewController.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseListViewController.h"
#import "BaseListViewDataSource.h"
#import "BaseListView.h"
#import "BaseListViewModel.h"
@interface BaseListViewController ()
@property (nonatomic, strong, readwrite) BaseListView   *listView;
@property (nonatomic, strong) BaseListViewDataSource *dataSource;
@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)bindViewModel {
    if (self.viewModel == nil) {
        self.viewModel = [[BaseListViewModel alloc]init];
    }
    
    self.dataSource = [[BaseListViewDataSource alloc ]initWithViewModel:(BaseListViewModel *)self.viewModel reuseIdentifier:@"BaseListViewCell"];
    [self.dataSource handleTableViewDataSourceAndDelegate:self.listView];
    
    
}

- (void)configContentView {
    [super configContentView];
    
    self.listView = [BaseListView initializeInstanceObject];
    self.listView.frame = self.bounds;
    [self addSubview:self.listView];
    
}

- (void)reloadviewWhenDatasourceChange {
    [self.listView reloadData];
}

@end
