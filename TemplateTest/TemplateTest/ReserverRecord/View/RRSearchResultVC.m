//
//  RRSearchResultVC.m
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "RRSearchResultVC.h"
#import "RRSearchResultViewModel.h"
#import "HWBaseRefreshView.h"
#import "ReserverRecordCell.h"

@interface RRSearchResultVC ()<UITableViewDataSource>
@property (nonatomic, strong) RRSearchResultViewModel *viewModel;
@property (nonatomic, strong) HWBaseRefreshView *listView;
@end

@implementation RRSearchResultVC
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configContentView {
    [super configContentView];
    
    self.listView = [[HWBaseRefreshView alloc]initWithFrame:self.view.bounds];
    self.listView.baseTable.dataSource = self;
    self.listView.cellHeight = ^(NSIndexPath *indexPath){
        return (CGFloat)kRate(122);
    };
    [self.contentView addSubview:self.listView];
}

- (void)bindViewModel {
    [super bindViewModel];
    [self.viewModel bindViewWithSignal];
    
    @weakify(self);
    [self.viewModel.command.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        [self.listView.baseTable reloadData];
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"ReserverRecordCell";
    ReserverRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ReserverRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.signal = [RACSignal return:[self.viewModel.dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
