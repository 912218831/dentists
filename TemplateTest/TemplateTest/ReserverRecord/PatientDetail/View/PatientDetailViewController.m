//
//  PatientDetailViewController.m
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "PatientDetailViewModel.h"
#import "HWBaseRefreshView.h"
#import "PatientDetailAbstractCell.h"
#import "PatientDetailPhotosCell.h"

@interface PatientDetailViewController ()<UITableViewDataSource>
@property (nonatomic, strong) PatientDetailViewModel *viewModel;
@property (nonatomic, strong) HWBaseRefreshView *listView;
@end

@implementation PatientDetailViewController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configContentView {
    [super configContentView];
    
    self.navigationItem.titleView = [Utility navTitleView:self.viewModel.patientName];
    
    self.listView = [[HWBaseRefreshView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64)];
    [self addSubview:self.listView];
    @weakify(self);
    self.listView.cellHeight = ^(NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.row) {
            case 0:
                return (CGFloat)kRate(223);
                break;
                
            default:{
                id value = self.viewModel.model.imagesCellsHeight[indexPath.row-1];
                return (CGFloat)[value floatValue];
            }
                break;
        }
    };
    self.listView.baseTable.dataSource = self;
}

- (void)bindViewModel {
    [super bindViewModel];
    [self.viewModel bindViewWithSignal];
    
    @weakify(self);
    [self.viewModel.requestSignal subscribeError:^(NSError *error) {
        @strongify(self);
        [self.listView.baseTable reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1+self.viewModel.model.imagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            NSString *cellId = @"PatientDetailAbstractCell";
            PatientDetailAbstractCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[PatientDetailAbstractCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            return cell;
        }
            break;
            
        default:
        {
            NSString *cellId = @"PatientDetailPhotosCell";
            PatientDetailPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[PatientDetailPhotosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            NSDictionary *item = [self.viewModel.model.imagesArray objectAtIndex:indexPath.row-1];
            NSArray *images = [item arrayObjectForKey:@"images"];
            cell.imagesSignal = [RACSignal return:[RACTuple tupleWithObjectsFromArray:images]];
            return cell;
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
