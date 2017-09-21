//
//  HWPeopleCenterHeadView.m
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWPeopleCenterHeadView.h"

@interface HWPeopleCenterHeadView ()

@end

@implementation HWPeopleCenterHeadView

- (void)initSubViews {
    self.backImageView = [UIImageView new];
    [self addSubview:self.backImageView];
    
    self.headerImageView = [UIImageView new];
    [self addSubview:self.headerImageView];
    
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    
    self.phoneLabel = [UILabel new];
    [self addSubview:self.phoneLabel];
}

- (void)layoutSubViews {
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).with.offset(kRate(39));
    }];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(kRate(73));
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(kRate(90));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_bottom).with.offset(kRate(13));
        make.centerX.equalTo(self.headerImageView);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(kRate(9));
        make.centerX.equalTo(self.headerImageView);
    }];
}

- (void)initDefaultConfigs {
    self.headerImageView.layer.borderWidth = 4;
    self.headerImageView.layer.borderColor = UIColorFromRGB(0xf3f3f5).CGColor;
    self.headerImageView.layer.cornerRadius = kRate(45);
    self.headerImageView.layer.masksToBounds = true;
    
    self.nameLabel.font = FONT(TF16);
    self.nameLabel.textColor = CD_Text;
    
    self.phoneLabel.font = FONT(TF16);
    self.phoneLabel.textColor = CD_Text;
    
    self.nameLabel.text = @"";
    self.phoneLabel.text = @"";
    
    self.backImageView.image = [UIImage imageNamed:@"personalCenter"];
}

@end
