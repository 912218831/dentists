//
//  HWPickerCell.h
//  
//
//  Created by 杨庆龙 on 15/10/22.
//
//

#import "HWTableViewCell.h"
#import "HWPickerItem.h"

@interface HWPickerCell : HWTableViewCell

@property (nonatomic, strong,readonly) UITextField *textField;
@property (nonatomic, strong,readonly) UILabel *valueLabel;
@property (nonatomic, strong,readonly) UILabel *placeholderLabel;
@property (nonatomic, strong,readonly) UILabel *titleLabel;
@property (nonatomic, strong,readonly) UIImageView *accessoryImgV;
@property (nonatomic, strong,readonly) UIView *pickerView;
@property (nonatomic, strong) HWPickerItem *item;
@property (nonatomic, strong) UIPickerView *picker;


@end
