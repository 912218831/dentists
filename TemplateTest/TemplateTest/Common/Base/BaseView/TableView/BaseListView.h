//
//  BaseListView.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseView.h"

@interface BaseListView : BaseView <ListViewProtocol>

@property (nonatomic, strong, readonly) UITableView *baseTableView;
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;
@property (nonatomic, assign)  id<UITableViewDataSource> dataSource;
@property (nonatomic, assign)  id<UITableViewDelegate> delegate;
+ (instancetype)initializeInstanceObject ;

@end
