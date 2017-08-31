//
//  HWTableViewManger.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewManger.h"
#import "HWTableViewItem.h"
#import "HWTableViewCell.h"
#import "HWTableViewTextCell.h"
#import "HWTitleAndLabelCell.h"
#import "HWPickerCell.h"
#import "HWCustomViewCell.h"
@interface HWTableViewManger()<UIScrollViewDelegate>

@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredXIBs;
@property (strong, readwrite, nonatomic) NSMutableArray *mutableSections;
@property (assign, readonly, nonatomic) CGFloat defaultTableViewSectionHeight;


@end

@implementation HWTableViewManger


- (id)initWithTableView:(UITableView *)tableView delegate:(id<HWTableViewManagerDelegate>)delegate
{
    self = [self initWithTableView:tableView];
    if (self)
    {
        self.delegate = delegate;
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        manager.enable = YES;
        manager.shouldResignOnTouchOutside = YES;
        manager.shouldToolbarUsesTextFieldTintColor = YES;
        manager.enableAutoToolbar = NO;
    }
    return self;
}

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self)
    {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = tableView;
        
        self.mutableSections = [NSMutableArray array];
        self.registeredClasses = [NSMutableDictionary dictionary];
        [self registerDefaultClasses];
    }
    return self;

}

- (NSArray *)sections
{
    return self.mutableSections;
}


- (void)registerDefaultClasses
{
    self[@"__NSCFConstantString"] = @"HWTableViewCell";
    self[@"__NSCFString"] = @"HWTableViewCell";
    self[@"NSString"] = @"HWTableViewCell";
    self[@"HWTableViewItem"] = @"HWTableViewCell";
    self[@"HWTextItem"] = @"HWTableViewTextCell";
    self[@"HWTitleAndLabelItem"] = @"HWTitleAndLabelCell";
    self[@"HWCountDownBtnItem"] = @"HWCountDownCell";
    self[@"HWPickerItem"] = @"HWPickerCell";
    self[@"HWCustomViewItem"] = @"HWCustomViewCell";
}
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self registerClass:objectClass forCellWithReuseIdentifier:identifier bundle:nil];
}

- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier bundle:(NSBundle *)bundle
{
    NSAssert(NSClassFromString(objectClass), ([NSString stringWithFormat:@"Item class '%@' does not exist.", objectClass]));
    NSAssert(NSClassFromString(identifier), ([NSString stringWithFormat:@"Cell class '%@' does not exist.", identifier]));
    self.registeredClasses[(id <NSCopying>)NSClassFromString(objectClass)] = NSClassFromString(identifier);
    
    // Perform check if a XIB exists with the same name as the cell class
    //
    if (!bundle)
        bundle = [NSBundle mainBundle];
    
    if ([bundle pathForResource:identifier ofType:@"nib"]) {
        self.registeredXIBs[identifier] = objectClass;
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:bundle] forCellReuseIdentifier:objectClass];
    }
}

- (id)objectAtKeyedSubscript:(id <NSCopying>)key
{
    return [self.registeredClasses objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self registerClass:(NSString *)key forCellWithReuseIdentifier:obj];
}


#pragma mark - setter

- (void)setKeyBoardDisMissMode:(UIScrollViewKeyboardDismissMode)keyBoardDisMissMode
{
    _keyBoardDisMissMode = keyBoardDisMissMode;
    self.tableView.keyboardDismissMode = keyBoardDisMissMode;

}

- (void)setTableViewFooter:(UIView *)tableViewFooter
{
    _tableViewFooter = tableViewFooter;
    self.tableView.tableFooterView = tableViewFooter;
}

- (void)setTableViewHeader:(UIView *)tableViewHeader
{
    _tableViewHeader = tableViewHeader;
    self.tableView.tableHeaderView = tableViewHeader;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableSections.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section >= self.mutableSections.count)
    {
        return 0;
    }
    return ((HWTableViewSection *)[self.mutableSections objectAtIndex:section]).items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    HWTableViewSection *section = [self.mutableSections objectAtIndex:indexPath.section];
    HWTableViewItem *item = [section.items objectAtIndex:indexPath.row];

    Class cellClass = [self classForCellAtIndexPath:indexPath];

    
    HWTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    void (^loadCell)(HWTableViewCell *cell) = ^(HWTableViewCell *cell) {
        cell.tableViewManager = self;
        
        if ([self.delegate conformsToProtocol:@protocol(HWTableViewManagerDelegate)] && [self.delegate respondsToSelector:@selector(tableView:willLoadCell:forRowAtIndexPath:)])
            [self.delegate tableView:tableView willLoadCell:cell forRowAtIndexPath:indexPath];
        
        [cell cellDidLoad];
        

        if ([self.delegate conformsToProtocol:@protocol(HWTableViewManagerDelegate)] && [self.delegate respondsToSelector:@selector(tableView:didLoadCell:forRowAtIndexPath:)])
            [self.delegate tableView:tableView didLoadCell:cell forRowAtIndexPath:indexPath];
    };

    
    if (cell == nil)
    {
        cell = [[cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    if ([cell isKindOfClass:[HWTableViewCell class]] && [cell respondsToSelector:@selector(loaded)] && !cell.loaded) {
        loadCell(cell);
    }

    cell.rowIndex = indexPath.row;
    cell.sectionIndex = indexPath.section;
    cell.cellIndexpath = indexPath;
    cell.parentTableView = tableView;
    cell.section = section;
    cell.item = item;
    [cell cellWillAppear];
    
    if (indexPath.row == 0) {
        [cell drawTopLine];
    }
    
    return cell;
    
}


#pragma mark - tableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mutableSections.count <= indexPath.section)
    {
        return 0;
    }
    HWTableViewSection * sectionManager = [self.mutableSections objectAtIndex:indexPath.section];
    HWTableViewItem * item = [sectionManager.items pObjectAtIndex:indexPath.row];
    return item.cellHeight ? item.cellHeight : 44 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.mutableSections.count <= section)
    {
        return 0;
    }
    HWTableViewSection * sectionManager = [self.mutableSections objectAtIndex:section];
    if (sectionManager.headerHeight)
    {
        return sectionManager.headerHeight;
    }
    
    return sectionManager.headerView  ? sectionManager.headerView.frame.size.height : 0.1;

}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (self.mutableSections.count <= section)
    {
        return 0;
    }
    
    
    HWTableViewSection * sectionManager = [self.mutableSections objectAtIndex:section];
    if (sectionManager.footerHeight)
    {
        return sectionManager.footerHeight;
    }

    return sectionManager.footerView  ? sectionManager.headerView.frame.size.height : 0.1;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.mutableSections.count <= section)
    {
        return nil;
    }
    HWTableViewSection * sectionManager = [self.mutableSections objectAtIndex:section];
    if ([self.delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)])
    {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    if (sectionManager.footerTitle)
    {
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionManager.headerHeight)];
        UILabel * titleLab = [UILabel newAutoLayoutView];
        [footer addSubview:titleLab];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0f];
        [titleLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        titleLab.text = sectionManager.headerTitle;
        titleLab.font = sectionManager.footerTitleFont;
        titleLab.textColor = sectionManager.footerTitleColor;

        return footer;
    }
    else
    {
        return sectionManager.footerView;

    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.mutableSections.count <= section) {
        return nil;
    }
    HWTableViewSection * sectionManger = [self.mutableSections objectAtIndex: section];
    
    if ([self.delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)])
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    if (sectionManger.headerTitle)
    {
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionManger.headerHeight)];
        UILabel * titleLab = [UILabel newAutoLayoutView];
        header.backgroundColor = sectionManger.headerBackgroundColor;
        [header addSubview:titleLab];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0f];
        [titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
        [titleLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        titleLab.text = sectionManger.headerTitle;
        titleLab.font = sectionManger.headerTitleFont;
        titleLab.textColor = sectionManger.headerTitleColor;
        titleLab.backgroundColor = [UIColor clearColor];

        return header;
    }
    else
    {
        return sectionManger.headerView;

    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWTableViewSection *section = [self.mutableSections objectAtIndex:indexPath.section];
    HWTableViewItem *item = [section.items objectAtIndex:indexPath.row];
    if (item.selectionHandler)
    {
        item.selectionHandler(item);
    }

}





#pragma mark - scrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.delegate scrollViewDidScroll:self.tableView];
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidZoom:)])
        [self.delegate scrollViewDidZoom:self.tableView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [self.delegate scrollViewWillBeginDragging:self.tableView];
    if (self.scrollViewBeginDrag)
    {
        self.scrollViewBeginDrag();
    }

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // Forward to UIScrollView delegate
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
        [self.delegate scrollViewWillEndDragging:self.tableView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // Forward to UIScrollView delegate
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [self.delegate scrollViewDidEndDragging:self.tableView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
        [self.delegate scrollViewWillBeginDecelerating:self.tableView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [self.delegate scrollViewDidEndDecelerating:self.tableView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [self.delegate scrollViewDidEndScrollingAnimation:self.tableView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
        return [self.delegate viewForZoomingInScrollView:self.tableView];
    
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
        [self.delegate scrollViewWillBeginZooming:self.tableView withView:view];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
        [self.delegate scrollViewDidEndZooming:self.tableView withView:view atScale:scale];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
        return [self.delegate scrollViewShouldScrollToTop:self.tableView];
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([self.delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
        [self.delegate scrollViewDidScrollToTop:self.tableView];
}



#pragma mark -
#pragma mark Managing sections

- (void)addSection:(HWTableViewSection *)section
{
    section.tableViewManager = self;
    [self.mutableSections addObject:section];
}

- (void)addSectionsFromArray:(NSArray *)array
{
    for (HWTableViewSection *section in array)
        section.tableViewManager = self;
    [self.mutableSections addObjectsFromArray:array];
}

- (void)insertSection:(HWTableViewSection *)section atIndex:(NSUInteger)index
{
    section.tableViewManager = self;
    [self.mutableSections insertObject:section atIndex:index];
}

- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes
{
    for (HWTableViewSection *section in sections)
        section.tableViewManager = self;
    [self.mutableSections insertObjects:sections atIndexes:indexes];
}

- (void)removeSection:(HWTableViewSection *)section
{
    [self.mutableSections removeObject:section];
}

- (void)removeAllSections
{
    [self.mutableSections removeAllObjects];
}

- (void)removeSectionIdenticalTo:(HWTableViewSection *)section inRange:(NSRange)range
{
    [self.mutableSections removeObjectIdenticalTo:section inRange:range];
}

- (void)removeSectionIdenticalTo:(HWTableViewSection *)section
{
    [self.mutableSections removeObjectIdenticalTo:section];
}

- (void)removeSectionsInArray:(NSArray *)otherArray
{
    [self.mutableSections removeObjectsInArray:otherArray];
}

- (void)removeSectionsInRange:(NSRange)range
{
    [self.mutableSections removeObjectsInRange:range];
}

- (void)removeSection:(HWTableViewSection *)section inRange:(NSRange)range
{
    [self.mutableSections removeObject:section inRange:range];
}

- (void)removeLastSection
{
    [self.mutableSections removeLastObject];
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    [self.mutableSections removeObjectAtIndex:index];
}

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes
{
    [self.mutableSections removeObjectsAtIndexes:indexes];
}

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HWTableViewSection *)section
{
    section.tableViewManager = self;
    [self.mutableSections replaceObjectAtIndex:index withObject:section];
}

- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray
{
    [self removeAllSections];
    [self addSectionsFromArray:otherArray];
}

- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections
{
    for (HWTableViewSection *section in sections)
        section.tableViewManager = self;
    [self.mutableSections replaceObjectsAtIndexes:indexes withObjects:sections];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    for (HWTableViewSection *section in otherArray)
        section.tableViewManager = self;
    [self.mutableSections replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray
{
    [self.mutableSections replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2
{
    [self.mutableSections exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [self.mutableSections sortUsingFunction:compare context:context];
}

- (void)sortSectionsUsingSelector:(SEL)comparator
{
    [self.mutableSections sortUsingSelector:comparator];
}


- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath
{
    HWTableViewSection *section = [self.mutableSections objectAtIndex:indexPath.section];
    NSObject *item = [section.items objectAtIndex:indexPath.row];
    return [self.registeredClasses objectForKey:item.class];
}



@end
