//
//  HWBaseTableViewCell.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@implementation HWBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //点击状态
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xeaeaea);
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self initiaContentView];
    }
    return self;
}

- (void)drawCellLine
{
    [self.contentView drawTopLine];
    [self.contentView drawBottomLine];
}

+ (float)getCellHeight:(id)model
{
    return 0;
}

- (void)initiaContentView
{
    
}

- (void)fillDataWithModel:(id)model
{
    
}

+ (NSString *)getCellIdentify
{
    return NSStringFromClass(self);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
