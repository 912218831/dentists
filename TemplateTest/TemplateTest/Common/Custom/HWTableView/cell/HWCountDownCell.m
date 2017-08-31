//
//  HWCountDownCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/12.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCountDownCell.h"

@interface HWCountDownCell()

@property (nonatomic,strong) UITextField * textFeild;
@property (nonatomic,strong) UIImageView * iconImgV;
@property (nonatomic,strong) UIButton * countDownBtn;

@property (nonatomic,strong) NSTimer * timer;


@property (nonatomic,assign) BOOL didSetUpConstraint;

@property (nonatomic,assign) NSInteger countDownNum;


@end

@implementation HWCountDownCell
@synthesize item = _item;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.iconImgV];
        [self.contentView addSubview:self.textFeild];
        [self.contentView addSubview:self.countDownBtn];
        [self.contentView updateConstraintsIfNeeded];
        [self.contentView setNeedsUpdateConstraints];
        self.countDownNum = 10;
    }
    return self;

}

#pragma mark - cellLifeCircle

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.textFeild.placeholder = _item.placeholder;
    self.textFeild.text = _item.value;
    self.iconImgV.image = _item.iconImg;
}

- (void)cellDidLoad
{

}

- (void)cellDidDisappear
{

}
#pragma mark - getter

- (UITextField *)textFeild
{
    if (_textFeild == nil)
    {
        _textFeild = [UITextField newAutoLayoutView];
        _textFeild.backgroundColor = [UIColor clearColor];
        _textFeild.font = FONT(15.0f);
        
    }
    return _textFeild;
}


- (UIImageView *)iconImgV
{
    if (_iconImgV == nil)
    {
        _iconImgV = [UIImageView newAutoLayoutView];
        _iconImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgV;
}

- (UIButton *)countDownBtn
{
    if (_countDownBtn == nil)
    {
        _countDownBtn = [UIButton newAutoLayoutView];
        [_countDownBtn setBackgroundImage:[Utility imageWithColor:CD_MainColor andSize:CGSizeMake(100, 44)] forState:UIControlStateNormal];
        [_countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _countDownBtn.titleLabel.font = FONT(13.0f);
        [_countDownBtn addTarget:self action:@selector(countDownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _countDownBtn;
}



#pragma mark - action

- (void)countDownBtnAction:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    if (_item.countDownBtnClick)
    {
        _item.countDownBtnClick(_item);
    }

    
}

- (void)countDown
{
    self.countDownNum--;
    if (self.countDownNum == 0)
    {
        [self.countDownBtn setBackgroundImage:[Utility imageWithColor:CD_MainColor andSize:CGSizeMake(100, 44)] forState:UIControlStateNormal];
        [self.countDownBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];

        self.countDownBtn.userInteractionEnabled = YES;
        self.countDownNum = 10;
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        [self.countDownBtn setBackgroundImage:[Utility imageWithColor:[UIColor grayColor] andSize:CGSizeMake(100, 44)] forState:UIControlStateNormal];
        [self.countDownBtn setTitle:[NSString stringWithFormat:@"%ld后重新获取",self.countDownNum] forState:UIControlStateNormal];
        self.countDownBtn.userInteractionEnabled = NO;
    }
    

}
#pragma mark - layout

- (void)updateConstraints
{
    if (!self.didSetUpConstraint)
    {
        //iconImgV
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
           
            [self.iconImgV autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
            [self.iconImgV autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
        
        [self.iconImgV autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0f];
        [self.iconImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        //countDowBtn
        [self.countDownBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeading];
        [self.countDownBtn autoSetDimension:ALDimensionWidth toSize:100];
        
        //inputTextFeild
        [self.textFeild autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.iconImgV withOffset:10.0f];
        [self.textFeild autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.countDownBtn withOffset:-5.0f];
        [self.textFeild autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.textFeild autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        self.didSetUpConstraint = YES;
    }
    [super updateConstraints];
}

@end
