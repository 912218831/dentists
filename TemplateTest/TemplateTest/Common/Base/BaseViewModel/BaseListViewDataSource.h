//
//  ListViewDataSource.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseListViewModel.h"

@interface BaseListViewDataSource : NSObject <UITableViewDataSource,
                                            UITableViewDelegate>
@property (nonatomic, strong, readonly) BaseListViewModel *viewModel;
+ (instancetype)initWithViewModel:(BaseListViewModel *)viewModel
                  reuseIdentifier:(NSString *)identifier;

- (void)handleTableViewDataSourceAndDelegate:(id)table;

@end
