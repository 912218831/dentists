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
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"
#import "PatientDetailSuggestDataSource.h"

@interface PatientDetailViewController ()<UITableViewDataSource>
@property (nonatomic, strong) PatientDetailViewModel *viewModel;
@property (nonatomic, strong) HWBaseRefreshView *listView;
@property (nonatomic, assign) int state;//0---
                                      //1---建议其他时间
@property (nonatomic, strong) PatientDetailSuggestDataSource *suggestDataSource;
@end

@implementation PatientDetailViewController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configContentView {
    [super configContentView];
    
    self.navigationItem.titleView = [Utility navTitleView:self.viewModel.patientName];
    
    self.listView = [[HWBaseRefreshView alloc]initWithGroupFrame:CGRectMake(0, 0, self.view.width, self.view.height-64)];
    [self addSubview:self.listView];
    @weakify(self);
    self.listView.cellHeight = ^(NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.row) {
            case 0:
                return self.state==0?(CGFloat)kRate(223):(indexPath.section==0?(CGFloat)kRate(344/2.0):(indexPath.section==1?kRate(238/2.0+10):kRate(305)));
                break;
                
            default:{
                if (self.state!=0) {
                    return kRate(238/2.0+10);
                }
                id value = self.viewModel.model.imagesCellsHeight[indexPath.row-1];
                return (CGFloat)[value floatValue];
            }
                break;
        }
    };
    self.listView.headerHeight = ^(NSInteger section) {
        return section==0?0.000001:(CGFloat)kRate(35);
    };
    self.listView.headerView = ^(NSInteger section) {
        @strongify(self);
        return [self.suggestDataSource tableView:self.listView.baseTable viewForHeaderInSection:section];
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
    return self.state==0?(1+self.viewModel.model.imagesArray.count):1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            NSString *cellId = @"PatientDetailAbstractCell";
            PatientDetailAbstractCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[PatientDetailAbstractCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                [cell bindSignal];
            }
            @weakify(self);
            [cell.suggestTapSignal subscribeNext:^(UIButton *suggestBtn) {
                @strongify(self);
                self.state = 1;
                if (self.suggestDataSource == nil) {
                    self.suggestDataSource = [[PatientDetailSuggestDataSource alloc ]initWithViewModel:self.viewModel reuseIdentifier:nil];
                }
                self.listView.baseTable.dataSource = self.suggestDataSource;
                [self.listView.baseTable reloadData];
            }];
            cell.state = self.state;
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
            HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
            
            NSMutableArray *temp = [NSMutableArray array];
            [images enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                HZPhotoItem *item = [[HZPhotoItem alloc] init];
                item.thumbnail_pic = src;
                [temp addObject:item];
            }];
            
            photoGroup.photoItemArray = [temp copy];
            [cell addSubview:photoGroup];
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
