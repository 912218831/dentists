//
//  HWGeneralControl.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWGeneralControl.h"


@implementation HWGeneralControl

+(UILabel *)createLabel:(CGRect)rect font:(UIFont *)font textAligment:(NSTextAlignment)textAligment textColor:(UIColor *)color
{
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:rect];
    generalLabel.font = font;
    generalLabel.backgroundColor = [UIColor clearColor];
    generalLabel.textAlignment = textAligment;
    generalLabel.textColor = color;
    return generalLabel;
}

+(UILabel *)createLabel:(CGRect)rect font:(UIFont *)font textAligment:(NSTextAlignment)textAligment textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor{
    UILabel *label = [self createLabel:rect font:font textAligment:textAligment textColor:color];
    label.backgroundColor  = backgroundColor;
    return  label;
}
//创建通用的UILabel
+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor
{
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:generalRect];
    generalLabel.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalLabel.backgroundColor = [UIColor clearColor];
    generalLabel.textAlignment = textAligment;
    generalLabel.textColor = labelColor;
    return generalLabel;
}

+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor text:(NSString *)text{
    UILabel *label = [self createLabel:generalRect font:fontSize textAligment:textAligment labelColor:labelColor];
    label.text = text;
 
    return label;
}

+(HWVerticalAlignedLabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor text:(NSString *)text numberOfLines:(NSInteger)number{
    
    HWVerticalAlignedLabel *label = [[HWVerticalAlignedLabel alloc]initWithFrame:generalRect];
    label.font = FONT(fontSize);
    label.textAlignment = textAligment;
    label.textColor = labelColor;
    label.text = text;
    label.numberOfLines = number;
    
    return label;
}
//创建通用的UIImageview
+(UIImageView *)createImageView:(CGRect)generalRect image:(NSString *)ImageStr
{
    UIImageView *generalImage = [[UIImageView alloc]initWithFrame:generalRect];
    generalImage.backgroundColor = [UIColor clearColor];
    generalImage.image = [UIImage imageNamed:ImageStr];
    return generalImage;
}
//创建通用的UITextField
+(UITextField *)createTextFieldView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag
{
    UITextField *generalTextField = [[UITextField alloc]initWithFrame:generalRect];
    generalTextField.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalTextField.tag = tag;
    generalTextField.backgroundColor = [UIColor clearColor];
    generalTextField.textAlignment = textAligment;
    generalTextField.textColor = textColor;
    generalTextField.delegate = delegate;
    generalTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return generalTextField;
}

+(HWCustomTextField *)createCustomTextFieldView:(CGRect)generalRect delegate:( id<UITextFieldDelegate>)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor  placeholder:(NSString *)placeholder{
    
    HWCustomTextField *generalTextField = [[HWCustomTextField alloc]initWithFrame:generalRect];
    generalTextField.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalTextField.textAlignment = textAligment;
    generalTextField.textColor = textColor;
    generalTextField.delegate = delegate;
    generalTextField.placeholder = placeholder;
    
    return generalTextField;
}
+(HWCustomTextField *)createCustomTextFieldView:(CGRect)generalRect delegate:(id<UITextFieldDelegate>)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType{
    HWCustomTextField *textField = [self createCustomTextFieldView:generalRect delegate:delegate textAligment:textAligment font:fontSize textColor:textColor placeholder:placeholder];
    textField.keyboardType = keyboardType;
    textField.clearButtonMode = clearButtonMode;
    return textField;
}
+(HWCustomTextField *)createCustomTextFieldView:(CGRect)generalRect delegate:(id<UITextFieldDelegate>)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor placeholder:(NSString *)placeholder clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    
     HWCustomTextField *textField = [self createCustomTextFieldView:generalRect delegate:delegate textAligment:textAligment font:fontSize textColor:textColor placeholder:placeholder clearButtonMode:clearButtonMode keyboardType:keyboardType ];
    textField.layer.borderColor = borderColor.CGColor;
    textField.layer.borderWidth = borderWidth;
    return textField;
}


+(UIButton *)createButtonWithFrame:(CGRect)frame{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    return button;
}

+(UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image{
    UIButton *button = [self createButtonWithFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    return  button;
}

+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor{
    
    UIButton *button=[self createButtonWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}

//创建通用的UIButton
+(UIButton *)createButton:(CGRect)generalRect font:(CGFloat)fontSize buttonTitleColor: (UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr
{
    UIButton *generalButton = [[UIButton alloc]initWithFrame:generalRect];
    [generalButton setBackgroundImage:[UIImage imageNamed:backImageStr] forState:UIControlStateNormal];
    [generalButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:fontSize]];
    [generalButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [generalButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [generalButton setTitle:titleStr forState:UIControlStateNormal];
    generalButton.backgroundColor = [UIColor clearColor];
    return generalButton;
    
}

+(UIButton *)createButtonWithFrame:(CGRect)frame buttonTitleFont:(UIFont *)font buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)titleColor{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame: frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
   
    
    return button;
}

+(UIButton *)createButtonWithFrame:(CGRect)frame buttonTitleFont:(UIFont *)font buttonTitle:(NSString *)
    title buttonTitleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor{
    
    UIButton *button = [self createButtonWithFrame:frame buttonTitleFont:font buttonTitle:title buttonTitleColor:titleColor];
    button.backgroundColor = backgroundColor;
    
    return button;
}



//创建UIView
+(UIView *)createView:(CGRect)generalRect
{
    UIView *generalView = [[UIView alloc]initWithFrame:generalRect];
    return generalView;
}

+(UIView *)createView:(CGRect)generalRect backgroundColor:(UIColor *)color{

    UIView *view = [self createView:generalRect];
    view.backgroundColor = color;
    
    return view;
}
+(UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color borderColor:(CGColorRef)borderColor borderWidth:(CGFloat)borderWidth{
    
    UIView *view=[self createView:frame backgroundColor:color];
    view.layer.borderColor=borderColor;
    view.layer.borderWidth=borderWidth;
    
    return view;
}

//创建通用的UITextview
+(UITextView *)createTextView:(CGRect)generalRect font:(CGFloat )fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment
{
    UITextView *generalTextView = [[UITextView alloc]initWithFrame:generalRect];
    generalTextView.font = [UIFont fontWithName:FONTNAME size:fontSize];
    generalTextView.backgroundColor = [UIColor clearColor];
    generalTextView.textAlignment = textAligment;
    generalTextView.textColor = textColor;
    generalTextView.delegate = delegate;
    return generalTextView;
}
//创建UITableView
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp
{
    UITableView *generalTableView = [[UITableView alloc]initWithFrame:generalRect style:UITableViewStylePlain];
    generalTableView.delegate = delegateTemp;
    generalTableView.dataSource = dataSourceDelegate;
    generalTableView.backgroundColor = [UIColor clearColor];
    generalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return generalTableView;
}
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp backgroundColor:(UIColor *)backgroundColor{

    UITableView *tableView =[self createTableView:generalRect dataSource:dataSourceDelegate delegate:delegateTemp];
    tableView.backgroundColor = backgroundColor;
    
    return tableView;
  
}
#pragma ----- UIImageView部分  --------
+(UIImageView*)createImageViewWithFrame:(CGRect)frame {
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[self createImageViewWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    return imageView ;
}
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    
    UIImageView *imageView=[self createImageViewWithFrame:frame ImageName:imageName];
    imageView.contentMode=contentMode;
    
    return imageView;
}

+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName imageTagValue:(NSInteger)tag{
    
    UIImageView *imageView=[self createImageViewWithFrame:frame ImageName:imageName];
    imageView.tag=tag;
    
    return imageView;
}
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds{
    
    UIImageView *imageView=[self createImageViewWithFrame:frame ImageName:imageName];
    imageView.layer.cornerRadius=cornerRadius;
    imageView.layer.masksToBounds=masksToBounds;
    return imageView;
}
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    UIImageView *imageView=[self createImageViewWithFrame:frame ImageName:imageName cornerRadius:cornerRadius masksToBounds:masksToBounds];
    imageView.layer.borderWidth=borderWidth;
    imageView.layer.borderColor=borderColor.CGColor;
    
    return imageView;
}

+(UITextField *)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder delegate:(id<UITextFieldDelegate>)delegate textfieldTextFont:(UIFont *)font clearButtonMode:(UITextFieldViewMode)clearButtonMode{
    
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.delegate=delegate;
    textField.placeholder=placeholder;
    textField.font=font;
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;

    return textField;
}

+(UITextField *)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id<UITextFieldDelegate>)delegate textfieldTextFont:(UIFont *)font clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType{
    
    UITextField *textField=[self creatTextfieldWithFrame:frame placeholder:placeholder delegate:delegate textfieldTextFont:font clearButtonMode:clearButtonMode];
    textField.keyboardType=keyboardType;
    
    return textField;
}

+(UITextField *)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id<UITextFieldDelegate>)delegate textfieldTextFont:(UIFont *)font clearButtonMode:(UITextFieldViewMode)clearButtonMode keyboardType:(UIKeyboardType)keyboardType textColor:(UIColor *)color{
    
    UITextField *textField=[self creatTextfieldWithFrame:frame placeholder:placeholder delegate:delegate textfieldTextFont:font clearButtonMode:clearButtonMode keyboardType:keyboardType];
    textField.textColor=color;
    
    return textField;
}



@end
