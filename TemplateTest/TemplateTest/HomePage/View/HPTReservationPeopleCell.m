//
//  HPTReservationPeopleCell.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HPTReservationPeopleCell.h"
#import "HPReserverListModel.h"

@interface HPTReservationPeopleCell ()
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *picNumLabel;
@property (nonatomic, strong) UILabel *patientDesLabel;
@end

@implementation HPTReservationPeopleCell

- (void)initSubViews {
    self.dotView = [UIView new];
    [self addSubview:self.dotView];
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    
    self.dateLabel = [UILabel new];
    [self addSubview:self.dateLabel];
    
    self.picNumLabel = [UILabel new];
    [self addSubview:self.picNumLabel];
    
    self.patientDesLabel = [UILabel new];
    [self addSubview:self.patientDesLabel];
}

- (void)layoutSubViews {
    self.dotView.frame = CGRectMake(kRate(15), kRate(16), kRate(8), kRate(8));
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dotView);
        make.left.equalTo(self.dotView.mas_right).with.offset(kRate(6));
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(kRate(11));
        make.left.equalTo(self.nameLabel);
    }];
    [self.picNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel);
        make.left.equalTo(self.picNumLabel.mas_right).with.offset(kRate(16));
    }];
    [self.patientDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).with.offset(kRate(11));
        make.left.equalTo(self.dateLabel);
    }];
}

- (void)initDefaultConfigs {
    self.dotView.layer.cornerRadius = self.dotView.width/2.0;
    self.dotView.layer.backgroundColor = CD_MainColor.CGColor;
    
    self.nameLabel.text = @"李先生";
    self.nameLabel.font = FONT(TF16);
    self.nameLabel.textColor = CD_Text;
    
    self.dateLabel.text = @"今天下午";
    self.dateLabel.font = FONT(TF14);
    self.dateLabel.textColor = CD_Text66;
    
    self.picNumLabel.text = @"共8张图片";
    self.picNumLabel.font = FONT(TF14);
    self.picNumLabel.textColor = CD_Text66;
    
    self.patientDesLabel.text = @"可能：牙龈癍严重";
    self.patientDesLabel.font = FONT(TF14);
    self.patientDesLabel.textColor = CD_Text66;
}

- (void)setValueSignal:(RACSignal *)valueSignal {
    @weakify(self);
    [valueSignal subscribeNext:^(HPReserverListModel *x) {
        @strongify(self);
        self.nameLabel.text = x.patientName;
        self.dateLabel.text = x.expectedTime;
        self.picNumLabel.text = [NSString stringWithFormat:@"共%@张图片",x.imageCount];
        self.patientDesLabel.text = x.machineReport;
    }];
}

@end
