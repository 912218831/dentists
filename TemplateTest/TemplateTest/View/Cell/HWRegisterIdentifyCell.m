//
//  HWRegisterIdentifyCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 2017/7/27.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "HWRegisterIdentifyCell.h"

@interface HWRegisterIdentifyCell()

@property(nonatomic,strong)UILabel * identifyLab;

@end

@implementation HWRegisterIdentifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.identifyLab];
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - kRate(52) - 10, 0, 10, 18)];
        imgV.centerY = kRate(60)/2;
        imgV.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:imgV];
        
        CALayer * line = [[CALayer alloc] init];
        line.frame = CGRectMake(kRate(47), kRate(60)-0.5, kScreenWidth - kRate(47)*2, 0.5);
        line.backgroundColor = COLOR_DEDEDE.CGColor;
        [self.contentView.layer addSublayer:line];

    }
    return self;
}

- (UILabel *)identifyLab
{
    if (_identifyLab == nil) {
        _identifyLab = [[UILabel alloc] initWithFrame:CGRectMake(kRate(52), 0, kScreenWidth - kRate(52)*2, kRate(60))];
        _identifyLab.font = FONT(16.0f);
        _identifyLab.textColor = COLOR_333333;
        _identifyLab.textAlignment = NSTextAlignmentLeft;
        _identifyLab.text = @"我是";
    }
    return _identifyLab;
}

- (void)configCellWithContent:(NSString *)content
{
    self.identifyLab.text = content.length ? content : @"我是";
}

+(float)getCellHeight
{
    return kRate(60);
}

@end
