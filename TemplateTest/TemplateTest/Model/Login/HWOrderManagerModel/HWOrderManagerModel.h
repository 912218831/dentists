//
//  HWOrderManagerModel.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
/**
 *
 orderFormNum = 710;
 orderFormStatus = "\U652f\U4ed8\U5931\U8d25";
 orderFormTime = 1437813202000;
 projectId = 12275460197;
 projectName = "fnn0725\U9879\U76ee";
 totalMoney = "10.2";
 */
#import <Foundation/Foundation.h>

@interface HWOrderManagerModel : NSObject
@property (nonatomic,strong,readonly) NSString * orderFormNum;/**<  订单号 */

@property (nonatomic,strong,readonly) NSString * price;/**<  总价 */

@property (nonatomic,strong,readonly) NSString * projectName;/**<  projectName */
@property (nonatomic,strong,readonly) NSString * orderFormStatus;/**<  订单状态 */


@property (nonatomic,strong,readonly) NSArray * content;


+ (HWOrderManagerModel *)modelWithDic:(NSDictionary*)dic;
@end
