//
//  ReserverRecordCell.m
//  TemplateTest
//
//  Created by HW on 17/9/4.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "ReserverRecordCell.h"

@interface ReserverRecordCell ()
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *patientDesLabel;
@property (nonatomic, strong) UILabel *noteLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *arrowButton;
@end

@implementation ReserverRecordCell

- (void)initSubViews {
    self.contentV = [UIView new];
    [self addSubview:self.contentV];
    
    self.photoImageView = [UIImageView new];
    self.nameLabel = [UILabel new];
    self.patientDesLabel = [UILabel new];
    self.noteLabel = [UILabel new];
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentV addSubview:self.photoImageView];
    [self.contentV addSubview:self.nameLabel];
    [self.contentV addSubview:self.patientDesLabel];
    [self.contentV addSubview:self.noteLabel];
    [self.contentV addSubview:self.confirmButton];
    [self.contentV addSubview:self.arrowButton];
}

- (void)layoutSubViews {
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kRate(13));
        make.right.equalTo(self).with.offset(-kRate(13));
        make.top.equalTo(self).with.offset(kRate(12));
        make.bottom.equalTo(self).with.offset(-1);
    }];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentV);
        make.left.equalTo(self.contentV).with.offset(kRate(16));
        make.width.height.mas_equalTo(kRate(55));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentV).with.offset(kRate(21));
        make.left.equalTo(self.photoImageView.mas_right).with.offset(kRate(13));
    }];
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(kRate(9));
    }];
    [self.patientDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.noteLabel.mas_bottom).with.offset(kRate(5));
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentV).with.offset(kRate(18));
        make.right.equalTo(self.contentV).with.offset(-kRate(14));
        make.width.mas_equalTo(kRate(50));
        make.height.mas_equalTo(kRate(26));
    }];
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentV).with.offset(-kRate(29));
        make.right.equalTo(self.contentV).with.offset(-kRate(14));
        make.width.mas_equalTo(kRate(8));
        make.height.mas_equalTo(kRate(15));
    }];
}

- (void)initDefaultConfigs {
    self.contentV.layer.cornerRadius = 3;
    self.contentV.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    self.contentV.layer.borderWidth = 1;
    self.contentV.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    
    self.nameLabel.text = @"张先生";
    self.nameLabel.font = BOLDFONT(TF16);
    self.nameLabel.textColor = CD_Text;
    self.noteLabel.text = @"希望预约到今早，希望确认";
    self.noteLabel.font = FONT(TF13);
    self.noteLabel.textColor = CD_Text66;
    self.patientDesLabel.text = @"希望预约到今早，希望确认";
    self.patientDesLabel.font = FONT(TF13);
    self.patientDesLabel.textColor = CD_Text66;
    
    self.photoImageView.backgroundColor = [UIColor redColor];
    self.photoImageView.layer.cornerRadius = kRate(55)/2.0;
    self.photoImageView.layer.masksToBounds = true;
    
    self.confirmButton.layer.cornerRadius = 3;
    self.confirmButton.layer.borderColor = UIColorFromRGB(0xfb6b35).CGColor;
    self.confirmButton.layer.borderWidth = 1;
    
    self.backgroundColor = COLOR_F3F3F3;
    self.arrowButton.normaleImgName = @"arrow";
    self.confirmButton.normalFont = FONT(TF13);
    self.confirmButton.normalTitle = @"待确认";
    self.confirmButton.normalColor = UIColorFromRGB(0xfb6b35);
}

@end
