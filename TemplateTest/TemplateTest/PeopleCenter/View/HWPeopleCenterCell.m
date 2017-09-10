//
//  HWPeopleCenterCell.m
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWPeopleCenterCell.h"
#import "DashLineView.h"

@interface HWPeopleCenterCell ()
@property (nonatomic, strong, readwrite) UIView *contentV;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) DashLineView *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation HWPeopleCenterCell

- (void)initSubViews {
    self.contentV = [UIView new];
    [self addSubview:self.contentV];
    
    self.titleLabel = [UILabel new];
    [self.contentV addSubview:self.titleLabel];
    
    self.logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentV addSubview:self.logoutBtn];
    
    self.lineView = [[DashLineView alloc]initWithLineHeight:0 space:0 direction:Horizontal strokeColor:UIColorFromRGB(0xcccccc)];
    [self.contentV addSubview:self.lineView];
    
    self.arrowImageView = [UIImageView new];
    [self.contentV addSubview:self.arrowImageView];
}

- (void)layoutSubViews {
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kRate(15));
        make.right.equalTo(self).with.offset(-kRate(15));
        make.top.equalTo(self).with.offset(1);
        make.bottom.equalTo(self).with.offset(-1);
    }];
    CGFloat offX = kRate(17);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentV);
        make.height.mas_equalTo(kRate(kRate(50)));
        make.left.equalTo(self.contentV).with.offset(offX);
    }];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentV).with.offset(offX);
        make.right.equalTo(self.contentV).with.offset(-offX);
        make.bottom.equalTo(self.contentV).with.offset(-kRate(24));
        make.height.mas_equalTo(kRate(40));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentV);
        make.height.mas_equalTo(0.6);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(-0.2);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentV).with.offset(-offX);
        make.width.mas_equalTo(kRate(8));
        make.height.mas_equalTo(kRate(15));
        make.centerY.equalTo(self.titleLabel);
    }];
}

- (void)initDefaultConfigs {
    self.contentV.layer.cornerRadius = 3;
    self.contentV.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    self.contentV.layer.borderWidth = 0.6;
    self.contentV.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    
    self.titleLabel.font = FONT(TF16);
    self.titleLabel.textColor = CD_Text;
    
    self.logoutBtn.backgroundColor = UIColorFromRGB(0xfa6c36);
    self.logoutBtn.normalColor = COLOR_FFFFFF;
    self.logoutBtn.normalFont = FONT(TF16);
    self.logoutBtn.normalTitle = @"退出";
    self.titleLabel.text = @"设置密码";
    
    self.arrowImageView.image = [UIImage imageNamed:@"arrow"];
}


@end

