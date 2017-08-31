//
//  HWPickerCell.m
//  
//
//  Created by 杨庆龙 on 15/10/22.
//
//

#import "HWPickerCell.h"

@interface HWPickerCell()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong,readwrite) UITextField *textField;
@property (nonatomic, strong,readwrite) UILabel *valueLabel;
@property (nonatomic, strong,readwrite) UILabel *placeholderLabel;
@property (nonatomic, strong,readwrite) UIPickerView *pickerView;
@property (nonatomic, strong,readwrite) UILabel *titleLab;
@property (nonatomic, strong,readwrite) UIImageView* accessoryImgV;
@property (nonatomic, strong) NSLayoutConstraint* valueAndAccessorySpace;

@property (nonatomic, assign) BOOL didSetUpConstraint;
@property (nonatomic, assign) BOOL didChangeframe;

@end

@implementation HWPickerCell
@synthesize item = _item;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.placeholderLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.accessoryImgV];
        [self updateConstraints];
    }
    return self;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.titleLab.text = self.item.title;
    if (self.item.titleFont)
    {
        self.titleLab.font = self.item.titleFont;
        
    }
    if (self.item.titleColor)
    {
        self.titleLab.textColor = self.item.titleColor;
        
    }
    
    
    self.valueLabel.text = self.item.value ? [self.item.value componentsJoinedByString:@""] : @"";
    if (self.item.valueFont)
    {
        self.valueLabel.font = self.item.valueFont;
        
    }
    if (self.item.valueColor)
    {
        self.valueLabel.textColor = self.item.valueColor;
        
    }
    
    
    self.placeholderLabel.text = self.item.placeholder;
    if (self.item.accessoryImg == nil)
    {
        self.valueAndAccessorySpace.constant = 0;
        self.accessoryImgV.image = [Utility imageWithColor:[UIColor clearColor] andSize:CGSizeMake(0.1, 0.1)];
    }
    else
    {
        self.valueAndAccessorySpace.constant = -10;
        self.accessoryImgV.image = self.item.accessoryImg;
        
    }
    
    
    
    if (self.item.selectedIndex != nil && self.item.selectedIndex.count == self.item.options.count)
    {
        for (NSInteger  index = 0; index < self.item.selectedIndex.count; index++)
        {
            [self.picker selectRow:[[self.item.selectedIndex objectAtIndex:index] integerValue] inComponent:index animated:YES];
        }
    }
    
}


- (UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [UITextField newAutoLayoutView];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.inputView = self.pickerView;
        _textField.alpha = 0;
        _textField.delegate = self;
    }

    return _textField;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.textField becomeFirstResponder];

    }

}

- (UIImageView *)accessoryImgV
{
    if (_accessoryImgV == nil)
    {
        _accessoryImgV = [UIImageView newAutoLayoutView];
        _accessoryImgV.contentMode = UIViewContentModeScaleAspectFit;
    }

    return _accessoryImgV;
}
- (UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [UILabel newAutoLayoutView];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.font = FONT(15.0f);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = CD_Text99;
    }
    return _titleLab;
}

- (UILabel *)valueLabel
{
    if (_valueLabel == nil)
    {
        _valueLabel = [UILabel newAutoLayoutView];
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.font = FONT(15.0f);
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}

- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil)
    {
        _placeholderLabel = [UILabel newAutoLayoutView];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.font = FONT(15.0f);
    }
    return _placeholderLabel;
}

- (UIView *)pickerView
{
    if (_pickerView == nil)
    {
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 226)];
        [_pickerView addSubview:self.picker];
        [_pickerView drawTopLine];
        _pickerView.backgroundColor = COLOR_F5F5F5;
        UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pickerView addSubview:sureBtn];
        sureBtn.frame = CGRectMake(15, CGRectGetHeight(self.picker.frame) + 10, kScreenWidth - 30, 44);
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(kScreenWidth - 30, 44)] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius = 3.0f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.layer.borderColor = CD_LineColor.CGColor;
        sureBtn.layer.borderWidth = 0.5;
    }
    return _pickerView;
}

- (UIPickerView *)picker
{
    if (_picker == nil)
    {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 156)];
        _picker.delegate = self;
        _picker.dataSource = self;

    }
    return _picker;
}




- (void)setItem:(HWPickerItem *)item
{
        _item = item;

}

#pragma mark - ConfigUI

- (void)updateConstraints
{
    if (!self.didSetUpConstraint)
    {
        [self.textField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [self.titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0f];
        [self.titleLab autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.titleLab autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.titleLab autoSetDimension:ALDimensionWidth toSize:0.1 relation:NSLayoutRelationGreaterThanOrEqual];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
           
            [self.titleLab autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
            [self.titleLab autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
        
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.placeholderLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.titleLab withOffset:10.0f];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.placeholderLabel autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
        }];
        [self.placeholderLabel autoSetDimension:ALDimensionWidth toSize:0.1 relation:NSLayoutRelationGreaterThanOrEqual];
        
        [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.valueLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.valueLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.placeholderLabel withOffset:10.0f];
        self.valueAndAccessorySpace = [self.valueLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.accessoryImgV withOffset:-10];
        
        [self.accessoryImgV autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15.0f];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.accessoryImgV autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
            [self.accessoryImgV autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
        [self.accessoryImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetUpConstraint = YES;
    }
    [super updateConstraints];
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [self setSelected:NO animated:NO];
    [self.item deselectRowAnimated:NO];
    [self shouldUpdateItemValue];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!self.selected)
    {
        [self setSelected:YES animated:NO];
        NSIndexPath * indexPath = [self indexPathForNextResponder];
        if (indexPath)
        {
            textField.returnKeyType = UIReturnKeyNext;
        }
        else
        {
            textField.returnKeyType = UIReturnKeyDefault;
        }
        
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    
    
    return YES;
}


#pragma mark - UIPickerViewDelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.item.options.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.item.options pObjectAtIndex:component] count];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * items = [self.item.options pObjectAtIndex:component];
    return [items pObjectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self shouldUpdateItemValue];
    if (self.item.onChange)
        self.item.onChange(self.item);
    [self.picker reloadAllComponents];
    [self shouldUpdateItemValue];


}


#pragma mark - privateMethod

- (void)shouldUpdateItemValue
{
    NSMutableArray * value = [NSMutableArray array];
    NSMutableArray * selectedIndex = [NSMutableArray array];
    [self.item.options enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        NSArray * options = [self.item.options pObjectAtIndex:idx];
        NSString * valueText = [options pObjectAtIndex:[self.picker selectedRowInComponent:idx]];
        [selectedIndex addObject:[NSString stringWithFormat:@"%ld",[self.picker selectedRowInComponent:idx]]];
        [value addObject:valueText];
    }];
    self.item.value = [value copy];
    if (self.textField.isEditing)
    {
        self.item.selectedIndex = [selectedIndex mutableCopy];
    }
    self.valueLabel.text = self.item.value ? [self.item.value componentsJoinedByString:@""] : @"";
    self.placeholderLabel.hidden = self.valueLabel.text.length > 0;
}

- (void)sureBtnClick:(id)sender
{
    [self shouldUpdateItemValue];
    if (self.item.onChange)
        self.item.onChange(self.item);
    [self.picker reloadAllComponents];
    [self shouldUpdateItemValue];
    
    [self.parentTableView endEditing:YES];
}

@end
