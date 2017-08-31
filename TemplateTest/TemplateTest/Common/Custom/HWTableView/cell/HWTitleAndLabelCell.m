//
//  HWTitleAndLabelCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTitleAndLabelCell.h"

@interface HWTitleAndLabelCell()

@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * contentLab;
@property (nonatomic,strong) UIImageView * acceccoryImgV;
@property (nonatomic,strong) UIImageView * iconImgV;
@property (nonatomic,strong) NSLayoutConstraint * iconAndTitleConstraint;

@property (nonatomic,assign) BOOL didSetUpConstraints;

@end

@implementation HWTitleAndLabelCell
@synthesize item = _item;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.acceccoryImgV];
        [self.contentView addSubview:self.iconImgV];
//        [self updateConstraints];
    }
    return self;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.titleLab.text = _item.title;
    if (_item.titleFont)
    {
        self.titleLab.font = _item.titleFont;

    }
    else
    {
        self.titleLab.font = FONT(15.0f);
    }
    if (_item.titleLineBreakMode)
    {
        self.titleLab.lineBreakMode = _item.titleLineBreakMode;
    }

    self.titleLab.textColor = _item.titleColor;
    
    
    self.contentLab.textAlignment = _item.contentAlign;
    self.contentLab.text = _item.value;
    self.contentLab.textColor = _item.contentColor;
    if (_item.contentFont)
    {
        self.contentLab.font = _item.contentFont;

    }
    else
    {
        self.contentLab.font = FONT(15.0f);

    }
    self.iconImgV.image = _item.iconImg;
    self.acceccoryImgV.image = _item.accessoryImg;

    [self setNeedsLayout];

}

- (UIImageView *)iconImgV
{
    if (_iconImgV == nil)
    {
        _iconImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgV;

}

- (UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.font = FONT(15.0f);
        _titleLab.text = _item.title;
    }
    
    return _titleLab;
}

- (UILabel *)contentLab
{
    if (_contentLab == nil)
    {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLab.font = FONT(15.0f);
        _contentLab.text = _item.value;
    }
    return _contentLab;
}

- (UIImageView *)acceccoryImgV
{
    if (_acceccoryImgV == nil)
    {
        _acceccoryImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _acceccoryImgV.image = _item.accessoryImg;
    }
    return _acceccoryImgV;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat contentWidth = [Utility calculateStringSize:_item.value font:_item.contentFont?_item.contentFont:FONT(15.0f) constrainedSize:CGSizeMake(kScreenWidth, 44)].width+5;
    if (_item.iconImg != nil)
    {
        self.iconImgV.frame = CGRectMake(15, (self.height - _item.iconImg.height)/2, _item.iconImg.width, _item.iconImg.height);
        self.titleLab.frame = CGRectMake(self.iconImgV.width+10, 0, kScreenWidth - _item.iconImg.width - _item.accessoryImg.width - 30 - contentWidth, self.height);
        
    }
    else
    {
        self.iconImgV.frame = CGRectMake(15, (self.height - _item.iconImg.height)/2, 0, 0);

        self.titleLab.frame = CGRectMake(15, 0, kScreenWidth - _item.iconImg.width - _item.accessoryImg.width - 30 - contentWidth, self.height);
    }
    if (_item.accessoryImg != nil) {
        self.acceccoryImgV.frame = CGRectMake(kScreenWidth - _item.accessoryImg.width - 15, (self.height - _item.accessoryImg.height)/2, _item.accessoryImg.width, _item.accessoryImg.height);
        self.contentLab.frame = CGRectMake(kScreenWidth - 15 - _item.accessoryImg.width - 10 - contentWidth , 0, contentWidth, self.height);
    }
    else
    {
        self.acceccoryImgV.frame = CGRectMake(kScreenWidth - _item.accessoryImg.width - 15, (self.height - _item.accessoryImg.height)/2, 0, 0);

        self.contentLab.frame = CGRectMake(kScreenWidth - 15 - contentWidth , 0, contentWidth, self.height);

    }
    
}

//- (void)updateConstraints
//{
//    if (!self.didSetUpConstraints)
//    {
//        
//        //iconImgV
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            
//            [self.iconImgV autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
//            [self.iconImgV autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
//        }];
//
//        [self.iconImgV autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0f];
//        [self.iconImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//        //titleLab
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//           
//            [self.titleLab autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
//            [self.titleLab autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
//        }];
//       self.iconAndTitleConstraint = [self.titleLab autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.iconImgV withOffset:10.0f];
//        [self.titleLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//
//        //contentLab
//        [self.contentLab autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.titleLab withOffset:5.0f];
//        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeTop];
//        [self.contentLab autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        
//        [self.contentLab autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.acceccoryImgV withOffset:-5.0f];
//        [self.contentLab autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.titleLab withOffset:5.0f];
//        //accessoryImgV
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            
//            [self.acceccoryImgV autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
//            [self.acceccoryImgV autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
//        }];
//
//        [self.acceccoryImgV autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15.0f];
//        [self.acceccoryImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
////        [self.acceccoryImgV autoSetDimensionsToSize:CGSizeMake(7, 22)];
//        [self.acceccoryImgV autoSetDimension:ALDimensionWidth toSize:0.1 relation:NSLayoutRelationGreaterThanOrEqual];
//        
//        self.didSetUpConstraints = YES;
//    }
//    [super updateConstraints];
//
//}

@end
