//
//  HWPeopleCenterCell.h
//  TemplateTest
//
//  Created by HW on 17/9/10.
//  Copyright © 2017年 caijingpeng.haowu. All rights reserved.
//

#import "BaseListViewCell.h"

#define kSetPasswordControlRect(cell) CGRectMake(0,0,cell.contentV.bounds.size.width,cell.titleLabel.bounds.size.height)

@interface HWPeopleCenterCell : BaseListViewCell
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong, readonly) UIView *contentV;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@end
