//
//  HWTableViewCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewCell.h"
#import "HWTableViewManger.h"
#import "HWTableViewItem.h"

#define bottomLineTag1 1111

@interface HWTableViewCell()

@property (nonatomic,assign) BOOL didSetUpConstraint;
@property (assign, readwrite, nonatomic) BOOL loaded;


@end

@implementation HWTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        [self.contentView drawBottomLine];
//        [self drawBottomLine];
//        self.backgroundColor = [UIColor clearColor];
//        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;

}

- (void)cellWillAppear
{
    [self drawBottomLine];
}

- (void)cellDidLoad
{
    self.loaded = YES;
}

- (void)cellDidDisappear
{

}

- (HWTableViewCellType)type
{
    if (self.rowIndex == 0 && self.section.items.count == 1)
        return HWTableViewCellTypeSingle;
    
    if (self.rowIndex == 0 && self.section.items.count > 1)
        return HWTableViewCellTypeFirst;
    
    if (self.rowIndex > 0 && self.rowIndex < self.section.items.count - 1 && self.section.items.count > 2)
        return HWTableViewCellTypeMiddle;
    
    if (self.rowIndex == self.section.items.count - 1 && self.section.items.count > 1)
        return HWTableViewCellTypeLast;
    
    return HWTableViewCellTypeAny;
}


+ (BOOL)canFocusWithItem:(HWTableViewItem *)item
{
    return NO;
}

- (UIResponder *)responder
{
    return nil;
}

- (NSIndexPath *)indexPathForPreviousResponderInSectionIndex:(NSUInteger)sectionIndex
{
    HWTableViewSection *section = [self.tableViewManager.sections objectAtIndex:sectionIndex];
    NSUInteger indexInSection =  [section isEqual:self.section] ? [section.items indexOfObject:self.item] : section.items.count;
    for (NSInteger i = indexInSection - 1; i >= 0; i--) {
        HWTableViewItem *item = [section.items objectAtIndex:i];
        if ([item isKindOfClass:[HWTableViewItem class]]) {
            Class class = [self.tableViewManager classForCellAtIndexPath:item.indexPath];
            if ([class canFocusWithItem:item])
                return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForPreviousResponder
{
    for (NSInteger i = self.sectionIndex; i >= 0; i--) {
        NSIndexPath *indexPath = [self indexPathForPreviousResponderInSectionIndex:i];
        if (indexPath)
            return indexPath;
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextResponderInSectionIndex:(NSUInteger)sectionIndex
{
    HWTableViewSection *section = [self.tableViewManager.sections objectAtIndex:sectionIndex];
    NSUInteger indexInSection =  [section isEqual:self.section] ? [section.items indexOfObject:self.item] : -1;
    for (NSInteger i = indexInSection + 1; i < section.items.count; i++) {
        HWTableViewItem *item = [section.items objectAtIndex:i];
        if ([item isKindOfClass:[HWTableViewItem class]]) {
            Class class = [self.tableViewManager classForCellAtIndexPath:item.indexPath];
            if ([class canFocusWithItem:item])
                return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextResponder
{
    for (NSInteger i = self.sectionIndex; i < self.tableViewManager.sections.count; i++) {
        NSIndexPath *indexPath = [self indexPathForNextResponderInSectionIndex:i];
        if (indexPath)
            return indexPath;
    }
    
    return nil;
}

- (void)drawBottomLine
{
    if ([self viewWithTag:bottomLineTag1] != nil) {
        [[self viewWithTag:bottomLineTag1] removeFromSuperview];
        
    }
    UIImageView * line = [UIImageView newAutoLayoutView];
    line.tag = bottomLineTag1;
    line.layer.masksToBounds = YES;
    line.clipsToBounds = YES;
    [self addSubview:line];
    
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    [line autoSetDimension:ALDimensionWidth toSize:kScreenWidth];
    
    //line.image = [UIImage imageNamed:@"celLine"];
    line.backgroundColor = CD_LineColor;
    
    
}



@end
