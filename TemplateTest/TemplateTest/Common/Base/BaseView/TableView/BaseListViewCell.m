//
//  BaseListViewCell.m
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseListViewCell.h"

@implementation BaseListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
        [self layoutSubViews];
        [self initDefaultConfigs];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubViews {}

- (void)layoutSubViews {}

- (void)initDefaultConfigs {}

- (void)reloadCellWhenDataSource:(BaseListItemModel *)item {
    
}

@end
