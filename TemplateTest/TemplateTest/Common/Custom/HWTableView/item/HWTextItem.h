//
//  HWTextItem.h
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewItem.h"

@interface HWTextItem : HWTableViewItem

// Data and values
//
@property (copy, readwrite, nonatomic) NSString *value;
@property (copy, readwrite, nonatomic) NSString *placeholder;
@property (nonatomic,strong) UIImage * iconImg;
@property (nonatomic,strong) UIImage * accessoryImg;
@property (nonatomic, strong) NSString* unit;

//textfeild

@property (nonatomic,strong) UIFont * textFeildFont;
@property (nonatomic,assign) NSTextAlignment  textFeildAlign;
@property (nonatomic,strong) UIView * inputView;
@property (nonatomic,strong) UIView * inputAccessoryView;

//title
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;


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
@property (copy, readwrite, nonatomic) void (^onBeginEditing)(HWTextItem *item);
@property (copy, readwrite, nonatomic) void (^onEndEditing)(HWTextItem *item);
@property (copy, readwrite, nonatomic) void (^onChange)(HWTextItem *item);
@property (copy, readwrite, nonatomic) void (^onReturn)(HWTextItem *item);
@property (copy, readwrite, nonatomic) BOOL (^onChangeCharacterInRange)(HWTextItem *item, NSRange range, NSString *replacementString);


+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
+ (instancetype)itemWithIconImg:(UIImage *)iconImg withPlaceHolder:(NSString *)placeHolder;
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value  placeholder:(NSString *)placeholder;

+ (instancetype)itemWithTitle:(NSString *)title unit:(NSString *)unit;
+ (instancetype)itemWithTitle:(NSString *)title withAccessoryImg:(UIImage *)accessoryImg unit:(NSString *)unit;


+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg;

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg;

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg unit:(NSString *)unit;




- (id)initWithTitle:(NSString *)title value:(NSString *)value;
- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;
- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg;
- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder withAccessoryImg:(UIImage *)accessoryImg withIcomImg:(UIImage *)iconImg unit:(NSString *)unit;


@end
