//
//  BaseListView.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseListView.h"

@interface BaseListView ()
@property (nonatomic, strong, readwrite) UITableView *baseTableView;
@end

@implementation BaseListView

+ (instancetype)initializeInstanceObject {
    BaseListView *listView = nil;
    listView = [[self alloc]init];
    if (listView) {
        
    }
    return listView;
}

- (instancetype)init {
    if (self = [super init]) {
        self.baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return self;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    _dataSource = dataSource;
    self.baseTableView.dataSource = dataSource;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    _delegate = delegate;
    self.baseTableView.delegate = delegate;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    self.baseTableView.frame = frame;
}

- (void)reloadData {//
    
    if (self.baseTableView.dataSource != nil) {
       [self.baseTableView reloadData];
    } else {
        @MYLog(@"未初始化数据源");
    }
    
}

@end
