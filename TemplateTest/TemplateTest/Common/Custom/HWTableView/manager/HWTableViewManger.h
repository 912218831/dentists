//
//  HWTableViewManger.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWTableViewSection.h"

@protocol HWTableViewManagerDelegate;


@interface HWTableViewManger : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (strong, readonly, nonatomic) NSArray *sections;

@property (weak, readwrite, nonatomic) UITableView *tableView;
@property (nonatomic,strong) UIView * tableViewHeader;
@property (nonatomic,strong) UIView * tableViewFooter;



- (id)initWithTableView:(UITableView *)tableView delegate:(id<HWTableViewManagerDelegate>)delegate;

- (id)initWithTableView:(UITableView *)tableView;

@property (assign, readwrite, nonatomic) id<HWTableViewManagerDelegate> delegate;

@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;

@property (assign,readwrite,nonatomic)UIScrollViewKeyboardDismissMode keyBoardDisMissMode;

@property (nonatomic,copy)  void (^scrollViewBeginDrag)(void);




- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier;

- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier bundle:(NSBundle *)bundle;

- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath;

- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

- (void)addSection:(HWTableViewSection *)section;

- (void)addSectionsFromArray:(NSArray *)array;

- (void)insertSection:(HWTableViewSection *)section atIndex:(NSUInteger)index;

- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

- (void)removeSection:(HWTableViewSection *)section;

- (void)removeAllSections;

- (void)removeSectionIdenticalTo:(HWTableViewSection *)section inRange:(NSRange)range;

- (void)removeSectionIdenticalTo:(HWTableViewSection *)section;

- (void)removeSectionsInArray:(NSArray *)otherArray;

- (void)removeSectionsInRange:(NSRange)range;

- (void)removeSection:(HWTableViewSection *)section inRange:(NSRange)range;

- (void)removeLastSection;

- (void)removeSectionAtIndex:(NSUInteger)index;

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HWTableViewSection *)section;

- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray;

- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray;

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;

- (void)sortSectionsUsingSelector:(SEL)comparator;


@property (strong, readonly, nonatomic) NSArray *errors;

@end


/**
 The delegate of a `RETableViewManager` object can adopt the `RETableViewManagerDelegate` protocol. Optional methods of the protocol allow the delegate to manage cells.
 */
@protocol HWTableViewManagerDelegate <UITableViewDelegate>

@optional

- (void)tableView:(UITableView *)tableView willLayoutCellSubviews:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView willLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;



@end
