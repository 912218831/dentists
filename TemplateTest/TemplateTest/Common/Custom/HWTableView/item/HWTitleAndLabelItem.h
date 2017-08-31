//
//  HWTitleAndLabelItem.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewItem.h"

@interface HWTitleAndLabelItem : HWTableViewItem
@property (nonatomic,strong) NSString * value; /**<  label的文本 */
@property (nonatomic,strong) UIImage * accessoryImg;
@property (nonatomic,strong) UIImage * iconImg; 


//title

@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIFont * titleFont;
@property (nonatomic, assign) NSLineBreakMode titleLineBreakMode;

//content

@property (nonatomic,strong) UIColor * contentColor;
@property (nonatomic,strong) UIFont * contentFont;
@property (nonatomic,assign) NSTextAlignment contentAlign;






+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title withIconImg:(UIImage *)iconImg withAccessroyImg:(UIImage *)accessoryImg;


+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString * )value;
+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg;
+(instancetype)itemWithTitle:(NSString *)title withAccessoryImg:(UIImage *)accessoryImg;

+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg withSelctionHander:(void(^)(HWTitleAndLabelItem * item))selectionHander;
+ (instancetype)itemWithTitle:(NSString *)title withValue:(NSString *)value withAccessoryImg:(UIImage *)accessoryImg withSelctionHander:(void(^)(HWTitleAndLabelItem * item))selectionHander withIconImg:(UIImage *)iconImg;


@end
