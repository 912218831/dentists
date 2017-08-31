//
//  HWGeneralControl.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//
//  功能描述：创建控件的通用方法
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-04-15           修改文件
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HWVerticalAlignedLabel.h"
#import "HWCustomTextField.h"


@interface HWGeneralControl : NSObject

+(UILabel *)createLabel:(CGRect)rect font:(UIFont *)font textAligment:(NSTextAlignment)textAligment textColor:(UIColor *)color;

+(UILabel *)createLabel:(CGRect)rect font:(UIFont *)font textAligment:(NSTextAlignment)textAligment textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;
//创建通用的UILabel
+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor;

+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor text:(NSString *)text;

+(HWVerticalAlignedLabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor text:(NSString *)text numberOfLines:(NSInteger)number;



//创建通用的UITableView
+(UIImageView *)createImageView:(CGRect)generalRect image:(NSString *)ImageStr;

//创建通用的UITextField
+(UITextField *)createTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag;
+(HWCustomTextField *)createCustomTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder;

+(HWCustomTextField *)createCustomTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType;

+(HWCustomTextField *)createCustomTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


//创建通用的UIButton
+(UIButton *)createButton:(CGRect)generalRect font:(CGFloat)fontSize buttonTitleColor: (UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr;
+(UIButton *)createButtonWithFrame:(CGRect)frame;
+(UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image;
+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor;
+(UIButton *)createButtonWithFrame:(CGRect)frame buttonTitleFont:(UIFont *)font buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)titleColor;
+(UIButton *)createButtonWithFrame:(CGRect)frame buttonTitleFont:(UIFont *)font buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor;


//创建UIView
+(UIView *)createView:(CGRect)generalRect;
+(UIView *)createView:(CGRect)generalRect backgroundColor:(UIColor *)color;
+(UIView*)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color borderColor:(CGColorRef )borderColor borderWidth:(CGFloat)borderWidth;

//创建UITextview
+(UITextView *)createTextView:(CGRect)generalRect font:(CGFloat )fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment;

//创建UITableView
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp;
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp backgroundColor:(UIColor *)backgroundColor;

#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName contentMode:(UIViewContentMode)contentMode;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName imageTagValue:(NSInteger)tag;
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

#pragma mark --创建UITextField
+(UITextField *)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder delegate:(id<UITextFieldDelegate>)delegate textfieldTextFont:(UIFont *)font clearButtonMode:(UITextFieldViewMode)clearButtonMode;
+(UITextField *)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder delegate:(id<UITextFieldDelegate>)delegate textfieldTextFont:(UIFont *)font clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType;
+(UITextField *)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder delegate:(id<UITextFieldDelegate>)delegate textfieldTextFont:(UIFont *)font clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType textColor:(UIColor *)color;

@end
