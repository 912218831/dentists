//
//  BaseListItemModel.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseModel.h"

@interface BaseListItemModel : BaseModel

/// 默认为 44，这个是影响 tableView 数据源的高度的- -- 之所以，这里就设置，是为了，缓存高度，避免，滚动 cell 的时候，不停的计算
@property (nonatomic, assign) CGFloat cellHeight;

@end
