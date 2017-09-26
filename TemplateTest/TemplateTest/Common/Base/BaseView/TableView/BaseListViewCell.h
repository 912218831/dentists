//
//  BaseListViewCell.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListItemModel.h"

@interface BaseListViewCell : UITableViewCell<BindSignal, HWBaseViewProtocol>
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)reloadCellWhenDataSource:(BaseListItemModel *)item;

@end
