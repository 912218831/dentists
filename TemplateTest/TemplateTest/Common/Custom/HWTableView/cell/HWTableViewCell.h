//
//  HWTableViewCell.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWTableViewSection.h"

@class HWTableViewManger;
@class HWTableViewItem;

typedef NS_ENUM(NSInteger, HWTableViewCellType) {
    HWTableViewCellTypeFirst,
    HWTableViewCellTypeMiddle,
    HWTableViewCellTypeLast,
    HWTableViewCellTypeSingle,
    HWTableViewCellTypeAny
};


@interface HWTableViewCell : UITableViewCell

@property (weak, readwrite, nonatomic) UITableView *parentTableView;
@property (weak, readwrite, nonatomic) HWTableViewManger *tableViewManager;

+ (CGFloat)heightWithItem:(HWTableViewItem *)item tableViewManager:(HWTableViewManger *)tableViewManager;

@property (strong, readonly, nonatomic) UIResponder *responder;
@property (strong, readonly, nonatomic) NSIndexPath *indexPathForPreviousResponder;
@property (strong, readonly, nonatomic) NSIndexPath *indexPathForNextResponder;

@property (assign, nonatomic) NSInteger rowIndex;
@property (assign, nonatomic) NSInteger sectionIndex;
@property (nonatomic, strong) NSIndexPath *cellIndexpath;

@property (weak, readwrite, nonatomic) HWTableViewSection *section;
@property (strong, readwrite, nonatomic) HWTableViewItem *item;
@property (assign, readonly, nonatomic) HWTableViewCellType type;


- (void)cellDidLoad;
- (void)cellWillAppear;
- (void)cellDidDisappear;

@property (assign, readonly, nonatomic) BOOL loaded;


@end
