//
//  HWBaseRefreshView.h
//  Template-OC
//
//  Created by hw500028 on 4/15/15.
//  Copyright (c) 2015 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWBaseRefreshViewObserverProtocol <NSObject>
- (void)sendAction:(NSString *)selectorString;
@end

@interface HWBaseRefreshView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL           isHeadLoading;
@property (nonatomic, assign) BOOL           isTailLoading;
@property (nonatomic, assign) BOOL           isNeedHeadRefresh;
@property (nonatomic, strong) UITableView    *baseTable;
@property (nonatomic, strong) NSMutableArray *baseListArr;
@property (nonatomic, assign) NSInteger      currentPage;
@property (nonatomic, assign) BOOL           isLastPage;
@property (nonatomic, assign) BOOL           isShowNoDataView;
@property (nonatomic, copy  ) CGFloat        (^cellHeight)(NSIndexPath *indexPath);
@property (nonatomic, copy  ) void           (^didSelected)(NSIndexPath *indexPath);
@property (nonatomic, assign) id<HWBaseRefreshViewObserverProtocol>
                                           observer;
- (void)queryListData;
- (void)doneLoadingTableViewData;

- (instancetype)initWithGroupFrame:(CGRect)frame;
- (void)showEmptyView:(NSString *)message;
- (void)showEmptyFail:(NSString *)message;
- (void)showEmpty:(NSString *)msg withOffset:(float)offset;
- (void)hideEmptyView;
- (void)showEmptyView:(NSString *)message withImage:(NSString *)image;


@end
