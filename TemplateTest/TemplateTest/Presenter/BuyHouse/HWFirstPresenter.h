//
//  HWFirstPresenter.h
//  TemplateTest
//
//  Created by zhangwei on 15/8/13.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWBannerModel.h"


@protocol HWFirstPresenterDelegate <NSObject>

- (void)bannerRequestSuccess:(NSMutableArray *)array;
- (void)bannerRequestFail:(NSMutableArray *)array;

@end


@interface HWFirstPresenter : NSObject

@property (nonatomic, assign) id<HWFirstPresenterDelegate> delegate;
@property (nonatomic, strong) HWBannerModel *bannerModel;
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)bannerByAppAdvertisementCityId:(NSString *)cityId;

@end
