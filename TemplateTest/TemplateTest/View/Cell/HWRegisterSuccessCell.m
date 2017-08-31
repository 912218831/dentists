//
//  HWRegisterSuccessCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWRegisterSuccessCell.h"

@interface HWRegisterSuccessCell()

@property(nonatomic,strong)UILabel * titleLab;
@property(strong,nonatomic)UILabel * contentLab;

@end

@implementation HWRegisterSuccessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        CALayer * line = [[CALayer alloc] init];
        line.frame = CGRectMake(kRate(47), kRate(60)-0.5, kScreenWidth - kRate(47)*2, 0.5);
        line.backgroundColor = COLOR_DEDEDE.CGColor;
        [self.contentView.layer addSublayer:line];

    }
    return self;
}

- (UILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kRate(52), 0, 70, kRate(60)-0.5)];
        _titleLab.font = FONT(16.0f);
        _titleLab.textColor = COLOR_999999;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.right+kRate(60), 0, kScreenWidth - self.titleLab.right - kRate(52) - kRate(60), kRate(60)-0.5)];
        _contentLab.textColor = COLOR_333333;
        _contentLab.font = FONT(16.0f);
        _contentLab.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLab;
}

- (void)configCellWithTitle:(NSString *)title content:(NSString *)content
{
    self.titleLab.text = title;
    self.contentLab.text = content;
}

+(float)getCellHeight
{
    return kRate(60);
}
@end
