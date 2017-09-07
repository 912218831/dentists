//
//  PatientDetailAbstractCell.m
//  TemplateTest
//
//  Created by HW on 17/9/5.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailAbstractCell.h"

@interface PatientDetailAbstractCell ()
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *confirmStateButton;
@property (nonatomic, strong) UIButton *confirmDateBtn;
@property (nonatomic, strong) UIButton *suggestDateBtn;
@end

@implementation PatientDetailAbstractCell

- (void)initSubViews {
    self.contentV = [UIView new];
    [self addSubview:self.contentV];
    
    self.photoImageView = [UIImageView new];
    self.nameLabel = [UILabel new];
    self.phoneLabel = [UILabel new];
    self.confirmStateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.suggestDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentV addSubview:self.photoImageView];
    [self.contentV addSubview:self.nameLabel];
    [self.contentV addSubview:self.phoneLabel];
    [self.contentV addSubview:self.confirmDateBtn];
    [self.contentV addSubview:self.confirmStateButton];
    [self.contentV addSubview:self.suggestDateBtn];
}

- (void)layoutSubViews {
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kRate(15));
        make.right.equalTo(self).with.offset(-kRate(15));
        make.top.equalTo(self).with.offset(kRate(10));
        make.bottom.equalTo(self).with.offset(-kRate(1));
    }];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentV).with.offset(kRate(18));
        make.top.equalTo(self.contentV).with.offset(kRate(21));
        make.width.height.mas_equalTo(kRate(55));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.photoImageView.mas_centerY).with.offset(-kRate(3));
        make.left.equalTo(self.photoImageView.mas_right).with.offset(kRate(12));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.photoImageView.mas_centerY).with.offset(kRate(3));
        make.left.equalTo(self.nameLabel.mas_left);
    }];
    [self.confirmDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.suggestDateBtn);
        make.bottom.equalTo(self.suggestDateBtn.mas_top).with.offset(-kRate(10));
    }];
    [self.suggestDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentV).with.offset(kRate(15));
        make.right.equalTo(self.contentV).with.offset(-kRate(15));
        make.height.mas_equalTo(kRate(41));
        make.bottom.equalTo(self.contentV).with.offset(-kRate(18));
    }];
    [self.confirmStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentV).with.offset(-kRate(23));
        make.top.equalTo(self.contentV).with.offset(kRate(24));
        make.height.mas_equalTo(kRate(25));
        make.width.mas_equalTo(kRate(50));
    }];
}

- (void)initDefaultConfigs {
    self.contentV.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    self.contentV.layer.cornerRadius = 3;
    self.contentV.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    self.contentV.layer.borderWidth = 0.6;
    
    self.photoImageView.layer.cornerRadius = kRate(55/2.0);
    self.photoImageView.layer.masksToBounds = true;
    
    self.backgroundColor = COLOR_F3F3F3;
    self.confirmStateButton.normalFont = FONT(TF13);
    self.confirmStateButton.normalTitle = @"待确认";
    self.confirmStateButton.normalColor = UIColorFromRGB(0xfb6b35);
    self.confirmStateButton.layer.cornerRadius = 3;
    self.confirmStateButton.layer.borderColor = UIColorFromRGB(0xfb6b35).CGColor;
    self.confirmStateButton.layer.borderWidth = 1;
    
    self.confirmDateBtn.normalColor = COLOR_FFFFFF;
    self.confirmDateBtn.normalFont = FONT(TF16);
    self.confirmDateBtn.backgroundColor = CD_MainColor;
    
    self.suggestDateBtn.normalColor = COLOR_FFFFFF;
    self.suggestDateBtn.normalFont = FONT(TF16);
    self.suggestDateBtn.backgroundColor = UIColorFromRGB(0xfa6c36);
    
    self.confirmDateBtn.normalTitle = @"确认预约到2017-08-01";
    self.suggestDateBtn.normalTitle = @"建议其他时间";
}

- (void)setState:(int)state {
    _state = state;
    
    self.suggestDateBtn.hidden = state != 0;
    [self.confirmDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (state == 0) {
            make.left.right.height.equalTo(self.suggestDateBtn);
            make.bottom.equalTo(self.suggestDateBtn.mas_top).with.offset(-kRate(10));
        } else {
            make.left.equalTo(self.contentV).with.offset(kRate(15));
            make.right.equalTo(self.contentV).with.offset(-kRate(15));
            make.height.mas_equalTo(kRate(41));
            make.bottom.equalTo(self.contentV).with.offset(-kRate(20));
        }
    }];
}

- (void)bindSignal {
    __block NSInteger count = 0;
    self.suggestTapSignal = [[self.suggestDateBtn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
        return (count++%2);
    }];
}

@end
