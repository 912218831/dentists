//
//  ListViewDataSource.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseListViewDataSource.h"
#import "BaseListView.h"
#import "BaseListViewCell.h"
#import "BaseListItemModel.h"

@interface BaseListViewDataSource ()

@property (nonatomic, strong, readwrite) BaseListViewModel *viewModel;
@property (nonatomic, copy  , readwrite) NSString          *identifier;

@end

@implementation BaseListViewDataSource

+ (instancetype)initWithViewModel:(BaseListViewModel *)viewModel reuseIdentifier:(NSString *)identifier {
    BaseListViewDataSource *dataSource = nil;
    dataSource = [[self alloc]init];
    if (dataSource ) {
        dataSource.viewModel = viewModel;
        dataSource.identifier = identifier;
    }
    return dataSource;
}

- (void)handleTableViewDataSourceAndDelegate:(id)table {
    BOOL result = isKindClass(table, "BaseListView");
    if (result) {
        BaseListView *listView = (BaseListView *)table;
        listView.dataSource = self;
        listView.delegate = self;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseListItemModel *item = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    
    return item.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (cell == nil) {
        cell = [[BaseListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier];
    }
    
    return cell;
}

@end
