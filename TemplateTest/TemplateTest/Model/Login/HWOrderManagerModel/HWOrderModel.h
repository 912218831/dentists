//
//  HWOrderModel.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
/*
"orderFormid":"", - 订单id 
 "groupDescription":"", - 团购描述 
 "productType":"", - 产品类型 
 "ticketType":"", - 交易类型 hwq：好屋券交易；tgq：团购券交易 
 "price":"", - 价格 
 
 2.0
 couponNum = "<null>";
 deliveryChannel = "<null>";
 groupDescription = "8\U4e07\U62b56\U4e07";
 orderFormid = 2573;
 price = 80000;
 productType = "8\U4e07\U4eab\U516d\U4e07";
 ticketType = tgq;
 */


#import <Foundation/Foundation.h>

@interface HWOrderModel : NSObject
@property (nonatomic,strong,readonly) NSString * picKey;
@property (nonatomic,strong,readonly) NSString * ticketType;/**<  hwq:好屋券 yhq:优惠券 */
@property (nonatomic,strong,readonly) NSString * price;
@property (nonatomic,strong,readonly) NSString * productType;/**<  产品类型 */
@property (nonatomic,strong,readonly) NSString * orderFormid; /**<  订单ID */
@property (nonatomic,strong,readonly) NSMutableAttributedString * groupDescription;/**<  团购描述 */
@property (nonatomic, strong,readonly) NSString *deliveryChannel;
@property (nonatomic, strong,readonly) NSMutableAttributedString *attributeTitle;
@property (nonatomic, strong,readonly) NSString *hwqProductType;
@property (nonatomic, strong) NSString *couponNum;/**<券码*/
@property (nonatomic, strong) NSString *customCouponNum;/**<券码:**** */




+ (HWOrderModel *)modelWithDic:(NSDictionary*)dic;


@end
