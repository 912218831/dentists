//
//  HWPickerItem.h
//  
//
//  Created by 杨庆龙 on 15/10/22.
//
//

#import "HWTableViewItem.h"

@interface HWPickerItem : HWTableViewItem

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSArray *value;
@property (nonatomic, strong) NSMutableArray *selectedIndex;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIImage *accessoryImg;


@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) UIColor *valueColor;





@property (nonatomic, copy) void (^onChange)(HWPickerItem * item);

+ (instancetype)itemWithTitle:(NSString *)title value:(NSArray *)value placeholder:(NSString *)placeholder options:(NSArray *)options;
+ (instancetype)itemWithTitle:(NSString *)title value:(NSArray *)value placeholder:(NSString *)placeholder options:(NSArray *)options accessory:(UIImage *)accessory;


@end
