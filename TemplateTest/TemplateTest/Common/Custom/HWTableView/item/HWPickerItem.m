//
//  HWPickerItem.m
//  
//
//  Created by 杨庆龙 on 15/10/22.
//
//

#import "HWPickerItem.h"

@implementation HWPickerItem

+ (instancetype)itemWithTitle:(NSString *)title value:(NSArray *)value placeholder:(NSString *)placeholder options:(NSArray *)options
{
    return [[self alloc] initWithTitle:title value:value placeholder:placeholder options:options accessory:nil];
}


+ (instancetype)itemWithTitle:(NSString *)title value:(NSArray *)value placeholder:(NSString *)placeholder options:(NSArray *)options accessory:(UIImage *)accessory
{
    return [[self alloc] initWithTitle:title value:value placeholder:placeholder options:options accessory:accessory];

}

- (id)initWithTitle:(NSString *)title value:(NSArray *)value placeholder:(NSString *)placeholder options:(NSArray *)options accessory:(UIImage *)accessory
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.value = value;
    //    self.style = UITableViewCellStyleValue1;
    self.placeholder = placeholder;
    self.value = value;
    self.options = options;
    self.accessoryImg = accessory;
    self.selectedIndex = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < self.options.count; index ++)
    {
        [self.selectedIndex addObject:[NSString stringWithFormat:@"ld",index]];
    }
    return self;
}


@end
