//
//  PatientDetailSuggestDataSource.m
//  TemplateTest
//
//  Created by HW on 17/9/6.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailSuggestDataSource.h"
#import "PatientDetailDateCell.h"
#import "GFCalendar.h"

@implementation PatientDetailSuggestDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:(section==1?2:1);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *headView = [UIView new];
    UIView *signView = [UIView new];
    UILabel *titleLabel = [UILabel new];
    [headView addSubview:signView];
    [headView addSubview:titleLabel];
    [signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).with.offset(kRate(15));
        make.top.equalTo(headView).with.offset(kRate(18));
        make.height.mas_equalTo(kRate(16));
        make.width.mas_equalTo(kRate(4));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(signView);
        make.left.equalTo(signView.mas_right).with.offset(kRate(10));
    }];
    signView.layer.cornerRadius = kRate(2);
    signView.layer.backgroundColor = CD_MainColor.CGColor;
    titleLabel.font = FONT(TF14);
    titleLabel.textColor = COLOR_999999;
    titleLabel.text = @"建议到08-01下午附近";
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            NSString *cellId = @"PatientDetailAbstractCell";
            PatientDetailAbstractCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[PatientDetailAbstractCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                [cell bindSignal];
            }
            cell.state = 1;
            return cell;
        }
            break;
            
        case 1:
        {
            NSString *cellId = @"PatientDetailDateCell";
            PatientDetailDateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[PatientDetailDateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                [cell bindSignal];
            }
            return cell;
        }
            break;
        default:
        {
            NSString *cellId = @"PatientDetailCalendarCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.backgroundColor = [UIColor clearColor];
            CGFloat width = kScreenWidth - kRate(30.0);
            CGPoint origin = CGPointMake(kRate(15), kRate(10));
            GFCalendarView *calendar = [[GFCalendarView alloc] initWithFrameOrigin:origin width:width];
            calendar.calendarBasicColor = CD_MainColor;
            calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
                
            };
            calendar.backgroundColor = COLOR_FFFFFF;
            [cell addSubview:calendar];
            return cell;
        }
            break;
    }
}

@end
