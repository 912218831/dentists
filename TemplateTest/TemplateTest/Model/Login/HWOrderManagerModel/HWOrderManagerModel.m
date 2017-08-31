//
//  HWOrderManagerModel.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWOrderManagerModel.h"
#import "HWOrderModel.h"
@interface HWOrderManagerModel()

@property (nonatomic,strong) NSString * orderFormNum;/**<  订单号 */

@property (nonatomic,strong) NSString * price;/**<  总价 */

@property (nonatomic,strong) NSString * projectName;/**<  projectName */
@property (nonatomic,strong) NSString * orderFormStatus;/**<  订单状态 */

@property (nonatomic,strong) NSArray * content;


@end

@implementation HWOrderManagerModel

+(HWOrderManagerModel *)modelWithDic:(NSDictionary *)dic
{
    HWOrderManagerModel * model = [[HWOrderManagerModel alloc]init];
    model.orderFormNum = [dic stringObjectForKey:@"orderFormNum"];
    model.orderFormStatus = [dic stringObjectForKey:@"orderFormStatus"];
    
    model.price = [NSString stringWithFormat:@"¥%@",[Utility operateDecimal:[dic stringObjectForKey:@"totalMoney"]]];
    model.projectName = [dic stringObjectForKey:@"projectName"];
    NSArray * tempArr = [dic arrayObjectForKey:@"myOrderDeailVoList"];
    NSMutableArray * tempMutableArr = [NSMutableArray array];
    for (NSDictionary * orderDic in tempArr) {
        HWOrderModel * orderModel = [HWOrderModel modelWithDic:orderDic];
        [tempMutableArr addObject:orderModel];
    }
    model.content = [NSArray arrayWithArray:tempMutableArr];
    return model;
}

@end
