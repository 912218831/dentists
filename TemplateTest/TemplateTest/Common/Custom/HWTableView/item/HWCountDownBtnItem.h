//
//  HWCountDownBtnItem.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/12.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewItem.h"

@interface HWCountDownBtnItem : HWTableViewItem
@property (copy, readwrite, nonatomic) NSString *value;
@property (copy, readwrite, nonatomic) NSString *placeholder;
@property (nonatomic,strong) UIImage * iconImg;

//textfeild

@property (nonatomic,strong) UIFont * textFeildFont;
@property (nonatomic,assign) NSTextAlignment  textFeildAlign;
@property (nonatomic,strong) UIView * inputView;
@property (nonatomic,strong) UIView * inputAccessoryView;

//title
@property (nonatomic,strong) UIColor * titleColor;
@property (nonatomic,strong) UIFont * titleFont;




@property (assign, readwrite, nonatomic) UITextFieldViewMode clearButtonMode;
@property (assign, readwrite, nonatomic) BOOL clearsOnBeginEditing;
@property (assign, readwrite, nonatomic) NSUInteger charactersLimit;

// Keyboard
//
@property (assign, readwrite, nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (assign, readwrite, nonatomic) UITextAutocorrectionType autocorrectionType;
@property (assign, readwrite, nonatomic) UITextSpellCheckingType spellCheckingType;
@property (assign, readwrite, nonatomic) UIKeyboardType keyboardType;
@property (assign, readwrite, nonatomic) UIKeyboardAppearance keyboardAppearance;
@property (assign, readwrite, nonatomic) UIReturnKeyType returnKeyType;
@property (assign, readwrite, nonatomic) BOOL enablesReturnKeyAutomatically;
@property (assign, readwrite, nonatomic) BOOL secureTextEntry;
@property (copy, readwrite, nonatomic) void (^onBeginEditing)(HWCountDownBtnItem *item);
@property (copy, readwrite, nonatomic) void (^onEndEditing)(HWCountDownBtnItem *item);
@property (copy, readwrite, nonatomic) void (^onChange)(HWCountDownBtnItem *item);
@property (copy, readwrite, nonatomic) void (^onReturn)(HWCountDownBtnItem *item);
@property (copy, readwrite, nonatomic) BOOL (^onChangeCharacterInRange)(HWCountDownBtnItem *item, NSRange range, NSString *replacementString);
@property (copy, readwrite, nonatomic) void (^countDownBtnClick)(HWCountDownBtnItem * item);



+ (instancetype)itemWithIconImg:(UIImage *)iconImg value:(NSString *)value;
+ (instancetype)itemWithIconImg:(UIImage *)iconImg withPlaceHolder:(NSString *)placeHolder;
+ (instancetype)itemWithIconImg:(UIImage *)iconImg value:(NSString *)value  placeholder:(NSString *)placeholder;

- (instancetype)initWithIconImg:(UIImage *)iconImg value:(NSString *)value placeholder:(NSString *)placeholder;


@end
