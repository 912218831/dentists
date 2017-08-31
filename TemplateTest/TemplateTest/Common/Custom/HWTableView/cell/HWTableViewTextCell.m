//
//  HWTableViewTextCell.m
//  TemplateTest
//
//  Created by 杨庆龙 on 15/8/1.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWTableViewTextCell.h"

@interface HWTableViewTextCell()

@property (nonatomic,strong) UIImageView * iconImgV;
@property (nonatomic,strong) UIImageView * accessoryImgV;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,assign) BOOL didSetUpConstraint;
@property (nonatomic, strong) UILabel* unitLab;
@property (nonatomic, assign) BOOL didChangeFrame;

@property (nonatomic, strong) NSLayoutConstraint *iconAndTitleSpace;

@end

@implementation HWTableViewTextCell
@synthesize item = _item;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.iconImgV];
        [self.contentView addSubview:self.accessoryImgV];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLab];
    }
    return self;
}

#pragma mark - cellLifeCircle

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.textField.text = self.item.value;
    self.textField.placeholder = self.item.placeholder;
    self.textField.textAlignment = self.item.textFeildAlign;
    self.textField.autocapitalizationType = self.item.autocapitalizationType;
    self.textField.autocorrectionType = self.item.autocorrectionType;
    self.textField.spellCheckingType = self.item.spellCheckingType;
    self.textField.keyboardType = self.item.keyboardType;
    self.textField.keyboardAppearance = self.item.keyboardAppearance;
    self.textField.returnKeyType = self.item.returnKeyType;
    self.textField.enablesReturnKeyAutomatically = self.item.enablesReturnKeyAutomatically;
    self.textField.secureTextEntry = self.item.secureTextEntry;
    self.textField.clearButtonMode = self.item.clearButtonMode;
    self.textField.clearsOnBeginEditing = self.item.clearsOnBeginEditing;
    self.textField.inputView = self.item.inputView;
    self.textField.inputAccessoryView = self.item.inputAccessoryView;
    self.textField.delegate = self;
    self.iconImgV.image = _item.iconImg;
    
    self.titleLab.text = _item.title;
    self.titleLab.textColor = _item.titleColor;
    if (_item.titleFont)
    {
        self.titleLab.font = _item.titleFont;
        
    }
    else
    {
        self.titleLab.font = FONT(15.0f);
        
    }

    self.unitLab.text = self.item.unit;
    self.accessoryImgV.image = _item.accessoryImg;

    [self setNeedsLayout];
}


- (void)cellDidLoad
{
    [super cellDidLoad];

}

#pragma mark - layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleWidth = [Utility calculateStringSize:_item.title font:_item.titleFont?_item.titleFont:FONT(15.0f) constrainedSize:CGSizeMake(kScreenWidth, 44)].width;
    CGFloat unitWidth = [Utility calculateStringSize:_item.unit font:FONT(15.0f) constrainedSize:CGSizeMake(kScreenWidth, 44)].width;
    if (_item.iconImg != nil) {
        
        self.iconImgV.frame = CGRectMake(15, (self.height - _item.iconImg.height)/2, _item.iconImg.width, _item.iconImg.height);
        self.titleLab.frame = CGRectMake(self.iconImgV.right + 10, 0, titleWidth, 44);
    }
    else
    {
        self.iconImgV.frame = CGRectMake(15, (self.height - _item.iconImg.height)/2, 0, 0);
        self.titleLab.frame = CGRectMake(15, 0, titleWidth, 44);

    }
    if (_item.accessoryImg != nil)
    {
        self.accessoryImgV.frame = CGRectMake(kScreenWidth - 15 - _item.accessoryImg.width, (self.height - _item.accessoryImg.height)/2, _item.accessoryImg.width, _item.accessoryImg.height);
        self.unitLab.frame = CGRectMake(self.accessoryImgV.left - 5 - unitWidth, 0, unitWidth, 44);
        
    }
    else
    {
        self.accessoryImgV.frame = CGRectMake(kScreenWidth - 15 - _item.accessoryImg.width, (self.height - _item.accessoryImg.height)/2, 0, 0);

        self.unitLab.frame = CGRectMake(self.accessoryImgV.left - 5 - unitWidth, 0, unitWidth, 44);

    }
    if (_item.unit)
    {
        self.textField.frame = CGRectMake(self.titleLab.right + 5, 0, kScreenWidth - 30 - _item.iconImg.width - _item.accessoryImg.width - titleWidth - unitWidth - 5 - 5, self.height);

    }
    else
    {
        self.textField.frame = CGRectMake(self.titleLab.right + 5, 0, kScreenWidth - 30 - _item.iconImg.width - _item.accessoryImg.width - titleWidth - 5, self.height);

    }

    
}

#pragma mark - getterMethod

- (UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = FONT(15.0f);
        [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.backgroundColor = [UIColor redColor];
    }
    return _textField;

}


- (UIImageView *)iconImgV
{
    if (_iconImgV == nil)
    {
        _iconImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgV;
}

- (UIImageView *)accessoryImgV
{
    if (_accessoryImgV == nil)
    {
        _accessoryImgV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _accessoryImgV.contentMode = UIViewContentModeScaleAspectFit;
        _accessoryImgV.image = [Utility imageWithColor:[UIColor redColor] andSize:CGSizeMake(30, 44)];
    }
    return _accessoryImgV;
}

- (UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}

- (UILabel *)unitLab
{
    if (_unitLab == nil)
    {
        _unitLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _unitLab.textAlignment = NSTextAlignmentRight;
        _unitLab.font = FONT(15.0f);
        _unitLab.backgroundColor = [UIColor clearColor];
    }
    return _unitLab;
}

#pragma mark - textFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField
{
    self.item.value = textField.text;
    if (self.item.onChange)
        self.item.onChange(self.item);
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.item.onBeginEditing)
        self.item.onBeginEditing(self.item);
    if (self.item.charactersLimit)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.item.onEndEditing)
        self.item.onEndEditing(self.item);


}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.item.onReturn)
        self.item.onReturn(self.item);
    if (self.item.onEndEditing)
        self.item.onEndEditing(self.item);
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (!indexPath) {
        [self endEditing:YES];
        return YES;
    }
    HWTableViewCell *cell = (HWTableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
    [cell.responder becomeFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = YES;
    
    if (self.item.onChangeCharacterInRange && shouldChange)
        shouldChange = self.item.onChangeCharacterInRange(self.item, range, string);
    
    return shouldChange;
}


- (void)textChange:(NSNotification *)notify
{
    UITextView *textView = (UITextView *)notify.object;
    NSString *toBeString = textView.text;

    if (self.item.charactersLimit)
    {
        //键盘输入模式（IOS7以后的方法）
        NSArray *currentArr = [UITextInputMode activeInputModes];
        UITextInputMode *currentMode = [currentArr firstObject];
        
        if ([currentMode.primaryLanguage isEqualToString:@"zh-Hans"])   //简体中文输入，包括简体拼音，健体五笔，简体手写
        {
            UITextRange *selectedRange = [textView markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            if (!position)
            {
                if (textView.text.length > self.item.charactersLimit)
                {
                    textView.text = [toBeString substringToIndex:self.item.charactersLimit];
                }
                
            }
            else
            {
                //            NSLog(@"此时键盘在输入 不限制");
            }
        }
        else
        {
            if (textView.text.length > self.item.charactersLimit)
            {
                textView.text = [toBeString substringToIndex:self.item.charactersLimit];
            }
        }
        
    }

}





@end
