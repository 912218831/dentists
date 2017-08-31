//
//  HWOrderModel.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
#import "HWOrderModel.h"

@interface HWOrderModel ()

@property (nonatomic,strong) NSString * picKey;
@property (nonatomic,strong) NSString * ticketType;/**<  hwq:好屋券 tgq:团购券 */
@property (nonatomic,strong) NSString * price;
@property (nonatomic,strong) NSString * productType;/**<  产品类型 */
@property (nonatomic,strong) NSString * orderFormid; /**<  订单ID */
@property (nonatomic,strong) NSMutableAttributedString * groupDescription;/**<  团购描述 */
@property (nonatomic, strong) NSString *deliveryChannel;
@property (nonatomic, strong) NSMutableAttributedString *attributeTitle;
@property (nonatomic, strong) NSString *hwqProductType;

@end

@implementation HWOrderModel
+(HWOrderModel *)modelWithDic:(NSDictionary *)dic
{
    HWOrderModel * model = [[HWOrderModel alloc]init];
    model.picKey = [dic stringObjectForKey:@"picKey"];
    model.hwqProductType = [NSString stringWithFormat:@"适用产品:%@",[dic stringObjectForKey:@"productType"]];
    model.productType = [dic stringObjectForKey:@"productType"];
    model.ticketType = [dic stringObjectForKey:@"ticketType"];
    
    NSString *string = [dic stringObjectForKey:@"price"];
    
    model.price = [NSString stringWithFormat:@"¥%@",[Utility operateDecimal:string]];
    model.orderFormid = [dic stringObjectForKey:@"orderFormid"];
    NSString * tempStr = [NSString stringWithFormat:@"团购费%@",[dic stringObjectForKey:@"groupDescription"]];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:tempStr];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:CD_MainColor range:NSMakeRange(3, [[dic stringObjectForKey:@"groupDescription"] length])];
    model.groupDescription = attributeStr;
    model.deliveryChannel = [dic stringObjectForKey:@"deliveryChannel"];
    NSString * title = [NSString stringWithFormat:@"好屋购房券%@",model.price];
    model.attributeTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [model.attributeTitle addAttribute:NSForegroundColorAttributeName value:CD_MainColor range:NSMakeRange(5, model.price.length)];
    model.couponNum = [dic stringObjectForKey:@"couponNum"];
    model.customCouponNum = [NSString stringWithFormat:@"券码:%@",[dic stringObjectForKey:@"couponNum"]];
    return model;
}


@end
