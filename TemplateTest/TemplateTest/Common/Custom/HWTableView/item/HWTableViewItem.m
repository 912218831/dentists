//
//  HWTableViewItem.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewItem.h"
#import "HWTableViewSection.h"
#import "HWTableViewManger.h"

@implementation HWTableViewItem


+ (instancetype)item
{
    return [[self alloc] init];
}

//+ (instancetype)itemWithTitle:(NSString *)title
//{
//    return [[self alloc]initWithTitle:title];
//}
//
//+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(HWTableViewItem *item))selectionHandler
//{
//    return [[self alloc]initWithTitle:title accessoryType:accessoryType selectionHandler:selectionHandler];
//}
//
//+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(HWTableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(HWTableViewItem *item))accessoryButtonTapHandler
//{
//    return [[self alloc]initWithTitle:title accessoryType:accessoryType selectionHandler:selectionHandler accessoryButtonTapHandler:accessoryButtonTapHandler];
//}
//
//- (id)initWithTitle:(NSString *)title
//{
//    self = [self init];
//    if (self)
//    {
//        self.title = title;
//    }
//    return self;
//}
//
//- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(HWTableViewItem *item))selectionHandler
//{
//    return [self initWithTitle:title accessoryType:accessoryType selectionHandler:selectionHandler accessoryButtonTapHandler:nil];
//
//}
//
//- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(HWTableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(HWTableViewItem *item))accessoryButtonTapHandler
//{
//    self = [self init];
//    if (self)
//    {
//        self.title = title;
//        self.accessoryType = accessoryType;
//        self.selectionHandler = selectionHandler;
//        self.accessoryButtonTapHandler = accessoryButtonTapHandler;
//
//    }
//    return self;
//}

- (NSIndexPath *)indexPath
{
    return [NSIndexPath indexPathForRow:[self.section.items indexOfObject:self] inSection:self.section.index];
}

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    self.enabled = YES;
    self.cellHeight = 0;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return self;
}


#pragma mark -
#pragma mark Manipulating table view row

- (void)selectRowAnimated:(BOOL)animated
{
    [self selectRowAnimated:animated scrollPosition:UITableViewScrollPositionNone];
}

- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    [self.section.tableViewManager.tableView selectRowAtIndexPath:self.indexPath animated:animated scrollPosition:scrollPosition];
}

- (void)deselectRowAnimated:(BOOL)animated
{
    [self.section.tableViewManager.tableView deselectRowAtIndexPath:self.indexPath animated:animated];
}

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation
{
    NSLog(@"%ld,section === %ld",self.indexPath.row,self.indexPath.section);
    [self.section.tableViewManager.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    
}

- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation
{
    HWTableViewSection *section = self.section;
    NSInteger row = self.indexPath.row;
    [section removeItemAtIndex:self.indexPath.row];
    [section.tableViewManager.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section.index]] withRowAnimation:animation];
}

@end
