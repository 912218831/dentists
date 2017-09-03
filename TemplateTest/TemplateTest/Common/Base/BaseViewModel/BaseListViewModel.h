//
//  BaseListViewModel.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseListViewModel : BaseViewModel
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;
@end
