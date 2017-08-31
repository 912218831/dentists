//
//  HWFirstPresenter.m
//  TemplateTest
//
//  Created by zhangwei on 15/8/13.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//      姓名      修改时间        修改内容
//     蔡景鹏     2015/9/8      代码结构整理

#import "HWFirstPresenter.h"

@implementation HWFirstPresenter
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)bannerByAppAdvertisementCityId:(NSString *)cityId
{
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setPObject:cityId forKey:@"cityId"];
    [manager POST:kAdvertisement parameters:param queue:nil success:^(id responese) {
        
        NSArray * arry = [responese arrayObjectForKey:@"data"];
        NSMutableArray * arr = [NSMutableArray array];
        [arry enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop)
         {
             HWBannerModel *model = [HWBannerModel modelWithDic:obj];
             [arr addObject:model];
             
         }];
        
        if (arr.count == 0)
        {
            [self contentDefaultSettingImage];
        }
        else
        {
            self.dataArray = arr;
        }
        
        if (delegate && [delegate respondsToSelector:@selector(bannerRequestSuccess:)])
        {
            [delegate bannerRequestSuccess:self.dataArray];
        }
        
        
    } failure:^(NSString *code, NSString *error) {
        
        if (delegate && [delegate respondsToSelector:@selector(bannerRequestFail:)])
        {
            [self contentDefaultSettingImage];
            [delegate bannerRequestFail:self.dataArray];
        }
    }];
    
}

- (void)contentDefaultSettingImage
{
    HWBannerModel *model = [[HWBannerModel alloc] init];
    model.advertisingType = @"-1";
    model.pictureUrl = [[NSBundle mainBundle] pathForResource:@"home_test_bg1" ofType:@"png"];
    self.dataArray = [NSMutableArray arrayWithObject:model];
}

@end
