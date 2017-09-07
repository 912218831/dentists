//
//  PatientDetailDateCell.m
//  TemplateTest
//
//  Created by HW on 17/9/6.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "PatientDetailDateCell.h"

@interface PatientDetailDateCell ()
@property (nonatomic, strong) UIView *contentV;
@end

@implementation PatientDetailDateCell

- (void)initSubViews {
    self.contentV = [UIView new];
    [self addSubview:self.contentV];
}

- (void)layoutSubViews {
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(kRate(15));
        make.right.equalTo(self).with.offset(-kRate(15));
        make.top.equalTo(self).with.offset(kRate(10));
        make.bottom.equalTo(self).with.offset(-kRate(1));
    }];
}

- (void)initDefaultConfigs {
    self.backgroundColor = COLOR_F3F3F3;
    
    self.contentV.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    self.contentV.layer.cornerRadius = 3;
    self.contentV.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    self.contentV.layer.borderWidth = 0.6;
}

@end
