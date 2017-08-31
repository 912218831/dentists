//
//  HWTableViewSection.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewSection.h"
#import "HWTableViewItem.h"
#import "HWTableViewManger.h"
@interface HWTableViewSection()

@property (strong, readwrite, nonatomic) NSMutableArray *mutableItems;


@end

@implementation HWTableViewSection


//- (CGFloat)maximumTitleWidthWithFont:(UIFont *)font {
//	
//}

+ (instancetype)section
{
    return [[self alloc]init];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle
{
    return [[self alloc]initWithHeaderTitle:headerTitle];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    return [[self alloc]initWithHeaderTitle:headerTitle footerTitle:footerTitle];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView
{
    return [[self alloc]initWithHeaderView:headerView];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView
{
    return [[self alloc]initWithHeaderView:headerView footerView:footerView];
}

- (id)initWithHeaderTitle:(NSString *)headerTitle
{
    return [self initWithHeaderTitle:headerTitle footerTitle:nil];
}

- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    self = [super init];
    if (self)
    {
        _mutableItems = [[NSMutableArray alloc] init];
        self.headerTitle = headerTitle;
        self.footerTitle = footerTitle;

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    _mutableItems = [[NSMutableArray alloc] init];
//    _headerHeight = RETableViewSectionHeaderHeightAutomatic;
//    _footerHeight = RETableViewSectionFooterHeightAutomatic;
//    _cellTitlePadding = 5;
    
    return self;
}


- (id)initWithHeaderView:(UIView *)headerView
{
    return [self initWithHeaderView:headerView footerView:nil];
}

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView
{
    self  = [super init];
    if (self)
    {
        _mutableItems = [[NSMutableArray alloc] init];
        self.headerView = headerView;
        self.footerView = footerView;
    }
    return self;
}

#pragma mark -
#pragma mark Reading information

- (NSUInteger)index
{
    HWTableViewManger *tableViewManager = self.tableViewManager;
    return [tableViewManager.sections indexOfObject:self];
}


#pragma mark -
#pragma mark Managing items

- (NSArray *)items
{
    return self.mutableItems;
}

- (void)addItem:(id)item
{
    if ([item isKindOfClass:[HWTableViewItem class]])
        ((HWTableViewItem *)item).section = self;

    [self.mutableItems addObject:item];
}

- (void)addItemsFromArray:(NSArray *)array
{
    for (HWTableViewItem *item in array)
        if ([item isKindOfClass:[HWTableViewItem class]])
            ((HWTableViewItem *)item).section = self;

    self.mutableItems = [NSMutableArray arrayWithArray:array];
}

- (void)insertItem:(id)item atIndex:(NSUInteger)index
{
    if ([item isKindOfClass:[HWTableViewItem class]])
        ((HWTableViewItem *)item).section = self;

    [self.mutableItems insertObject:item atIndex:index];
}

- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes
{
    for (HWTableViewItem *item in items)
        if ([item isKindOfClass:[HWTableViewItem class]])
            ((HWTableViewItem *)item).section = self;

    [self.mutableItems insertObjects:items atIndexes:indexes];
}

- (void)removeItem:(id)item
{
    [self.mutableItems removeObject:item];
}

- (void)removeAllItems
{
    [self.mutableItems removeAllObjects];
}

- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range
{
    [self.mutableItems removeObjectIdenticalTo:item inRange:range];
}

- (void)removeItemIdenticalTo:(id)item
{
    [self.mutableItems removeObjectIdenticalTo:item];
}

- (void)removeItemsInArray:(NSArray *)otherArray
{
    [self.mutableItems removeObjectsInArray:otherArray];
}

- (void)removeItemsInRange:(NSRange)range {
    [self.mutableItems removeObjectsInRange:range];
}

- (void)removeItem:(id)item inRange:(NSRange)range
{
    [self.mutableItems removeObject:item inRange:range];
}

- (void)removeLastItem
{
    [self.mutableItems removeLastObject];
}

- (void)removeItemAtIndex:(NSUInteger)index
{
    [self.mutableItems removeObjectAtIndex:index];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes
{
    [self.mutableItems removeObjectsAtIndexes:indexes];
}

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item
{
    if ([item isKindOfClass:[HWTableViewItem class]])
        ((HWTableViewItem *)item).section = self;
    [self.mutableItems replaceObjectAtIndex:index withObject:item];
}

- (void)replaceItemsWithItemsFromArray:(NSArray *)otherArray
{
    [self removeAllItems];
    [self addItemsFromArray:otherArray];
}

- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items {
    for (HWTableViewItem *item in items)
        if ([item isKindOfClass:[HWTableViewItem class]])
            ((HWTableViewItem *)item).section = self;
    [self.mutableItems replaceObjectsAtIndexes:indexes withObjects:items];


}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
    for (HWTableViewItem *item in otherArray)
        if ([item isKindOfClass:[HWTableViewItem class]])
            ((HWTableViewItem *)item).section = self;
    
    [self.mutableItems replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];

}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray {
    for (HWTableViewItem *item in otherArray)
        if ([item isKindOfClass:[HWTableViewItem class]])
            ((HWTableViewItem *)item).section = self;
    
    [self.mutableItems replaceObjectsInRange:range withObjectsFromArray:otherArray];

}

- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2 {
    [self.mutableItems exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];

}

- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context {
    [self.mutableItems sortUsingFunction:compare context:context];

}

- (void)sortItemsUsingSelector:(SEL)comparator {
    [self.mutableItems sortUsingSelector:comparator];

}

#pragma mark -
#pragma mark Manipulating table view section

- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation {
    
    [self.tableViewManager.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.index] withRowAnimation:animation];

}
@end
