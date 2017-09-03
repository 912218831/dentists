//
//  DoubleLabelButton.m
//  TemplateTest
//
//  Created by HW on 17/9/3.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "DoubleLabelButton.h"

@interface DoubleLabelButton ()
@property (nonatomic, strong, readwrite) UILabel *topLabel;
@property (nonatomic, strong, readwrite) UILabel *bottomLabel;
@end

@implementation DoubleLabelButton

- (instancetype)init {
    if (self = [super init]) {
        self.topLabel = [UILabel new];
        self.bottomLabel = [UILabel new];
        
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
    }
    return self;
}

- (instancetype)initWithTopHeight:(CGFloat)topHeight spaceY:(CGFloat)space {
    if (self = [self init]) {
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.height.mas_equalTo(topHeight);
        }];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self).with.offset(topHeight+space);
        }];
        
        self.topLabel.font = FONT(TF30);
        self.topLabel.textColor = CD_MainColor;
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.font = FONT(TF13);
        self.bottomLabel.textColor = CD_Text;
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
