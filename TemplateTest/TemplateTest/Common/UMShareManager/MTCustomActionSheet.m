//
//  MTCustomActionSheet.m
//  etonkids-iphone
//
//  Created by CaiJingPeng on 13-8-6.
//  Copyright (c) 2013年 wpf. All rights reserved.
//

#import "MTCustomActionSheet.h"

#define AS_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define AS_ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define AS_MainColor    UIColorFromRGB(0xFFFFFF)

#define AS_CubeWidth    50
#define AS_CubeHeight   80

@implementation MTCustomActionSheet

@synthesize delegate;
@synthesize buttons;
@synthesize sureButtonStyle;
@synthesize hideCtrl = _hideCtrl;
@synthesize mainView = _mainView;
@synthesize datepicker = _datepicker;
@synthesize numberOfRow;

- (id)initWithImages:(NSArray *)imgArr names:(NSArray *)nameArr
{
    self = [super init];
    if (self)
    {
        // Initialization code
        
        self.frame = CGRectMake(0, 0, AS_ScreenWidth, AS_ScreenHeight);
        //每行最对三个
        if (nameArr.count > 3) {
            self.numberOfRow = 3;
        }
        else
        {
            self.numberOfRow = nameArr.count;
        }
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        
        count = imgArr.count;
        CGFloat height = 30 + (count / (self.numberOfRow + 1) + 1) * (AS_CubeHeight + 20) + 55;
        
        self.hideCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - height)];
        self.hideCtrl.backgroundColor = [UIColor clearColor];
        [self.hideCtrl addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.hideCtrl];
        
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, height)];
        self.mainView.backgroundColor = COLOR_F3F3F3;
        [self addSubview:self.mainView];
        
        CGFloat gap = (AS_ScreenWidth - AS_CubeWidth * self.numberOfRow) / (self.numberOfRow + 1);
        
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setFrame:CGRectMake(0, 0, self.frame.size.width - 30, 40)];
        cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.layer.cornerRadius = 4;
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.borderWidth = 0.5;
        cancelBtn.layer.borderColor = CD_LineColor.CGColor;
        [cancelBtn setCenter:CGPointMake(self.frame.size.width / 2.0f, CGRectGetHeight(self.mainView.frame) - 20 - 15)];
        [cancelBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:cancelBtn.frame.size] forState:UIControlStateNormal];
        cancelBtn.tag = 777 + imgArr.count;
        [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:cancelBtn];
        
    }
    return self;
}


- (id)initWithTitle:(NSString *)title delegate:(id<MTCustomActionSheetDelegate>)myDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        
        NSMutableArray* arrays = [NSMutableArray array];
        
        va_list argList;
        
        if (otherButtonTitles)
        {
            [arrays addObject:otherButtonTitles];
            va_start(argList, otherButtonTitles);
            
            NSString *arg;
            while ((arg = va_arg(argList, NSString *)))
            {
                
                if (arg) {
                    //                    NSString *str=[NSString stringWithFormat:@"%@",arg];
                    [arrays addObject:arg];
                }
            }
            va_end(argList);
            
        }
        
        if (cancelButtonTitle != nil) {
            [arrays addObject:cancelButtonTitle];
        }
        
        self.delegate = myDelegate;
        
        self.buttons = arrays;
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectZero];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        
        int h = 10; // 计算高度.
        
        if (title != nil)
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, [UIScreen mainScreen].bounds.size.width - 50, 30)];
            titleLabel.text = title;
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.mainView addSubview:titleLabel];
            
            h += 30;
        }
        
        for (int i = 0; i < self.buttons.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:[self.buttons objectAtIndex:i] forState:UIControlStateNormal];
            
            if (cancelButtonTitle != nil && i == self.buttons.count - 1)
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"cancelDeep.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"loginBtn.png"] forState:UIControlStateNormal];
            }
            
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(30, h + 10 + (40 + (i == self.buttons.count - 1 ? 13 : 10)) * i, [UIScreen mainScreen].bounds.size.width - 60, 45)];
            btn.tag = 777 + i;
            
            [btn addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainView addSubview:btn];
        }
        self.mainView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, h + self.buttons.count * 50 + 10 + 13);
    }
    return self;
}

#pragma mark -- DatePicker --


- (id)initWithDatePicker:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, AS_ScreenWidth, AS_ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.datepicker];
        self.datepicker.date = date;
        [self addSubview:self.hideCtrl];
        
        [self createSureButton];
        [sureBtn addTarget:self action:@selector(doClickByDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark -- CustomPicker --

- (id)initWithCustomPicker:(NSArray *)titles
{
    self = [super init];
    if (self)
    {
        _titleArray = titles;
        
        self.frame = CGRectMake(0, 0, AS_ScreenWidth, AS_ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.picker];
        [self addSubview:self.hideCtrl];
        
        [self createSureButton];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setnumberOfRow:(NSInteger)number
{
    numberOfRow = number;
    
    CGFloat height = 30 + (count / (self.numberOfRow + 1) + 1) * (AS_CubeHeight + 20) + 55;
    
    self.hideCtrl.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - height);
    self.mainView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, height);
    [cancelBtn setCenter:CGPointMake(self.frame.size.width / 2.0f, CGRectGetHeight(self.mainView.frame) - 20 - 15)];
    
    CGFloat cubeWidth = 50;
    
    CGFloat gap = (AS_ScreenWidth - cubeWidth * numberOfRow) / (numberOfRow + 1);
    
    for (int i = 0; i < count; i++)
    {
        UIView *button = [self.mainView viewWithTag:777 + i];
        button.frame = CGRectMake(i % self.numberOfRow * (gap + cubeWidth) + gap,
                                  40 + i / self.numberOfRow * 100,
                                  cubeWidth,
                                  cubeWidth);
    }
}

- (void)setSureButtonStyle:(SureButtonStyle)style
{
    sureButtonStyle = style;
    [self createSureButton];
}

- (void)reloadMainFrame
{
    if (sureButtonStyle == SureButtonInputAccessory)
    {
        if (_picker != nil)
        {
            self.picker.frame = CGRectMake(0, 40, AS_ScreenWidth, 216);
        }
        
        if (_datepicker != nil)
        {
            self.datepicker.frame = CGRectMake(0, 40, AS_ScreenWidth, 216);
        }
    }
    else if (sureButtonStyle == SureButtonBottom)
    {
        if (_picker != nil)
        {
            self.picker.frame = CGRectMake(0, 0, AS_ScreenWidth, 196);
        }
        
        if (_datepicker != nil)
        {
            self.datepicker.frame = CGRectMake(0, 0, AS_ScreenWidth, 196);
        }
    }
}

- (void)createSureButton
{
    if (sureBtn == nil)
    {
        sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mainView addSubview:sureBtn];
    }
    
    [self reloadMainFrame];
    
    if (sureButtonStyle == SureButtonInputAccessory)
    {
        sureBtn.frame = CGRectMake(AS_ScreenWidth - 15 - 45, (40 - 30) / 2, 45, 30);
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = FONT(18);
        sureBtn.backgroundColor = [UIColor cyanColor];
        sureBtn.layer.cornerRadius = 3;
        sureBtn.layer.masksToBounds = YES;
    }
    else if (sureButtonStyle == SureButtonBottom)
    {
        sureBtn.frame = CGRectMake(15, 196 + 10, AS_ScreenWidth - 30, 40);
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
//        [sureBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:sureBtn.frame.size] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius = 3.0f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sureBtn.layer.borderColor = CD_LineColor.CGColor;
        sureBtn.layer.borderWidth = 0.5;
    }
    
}

- (UIView *)mainView
{
    if (_mainView == nil)
    {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, AS_ScreenHeight, AS_ScreenWidth, 256)];
        _mainView.backgroundColor = AS_MainColor;
    }
    return _mainView;
}

- (UIPickerView *)picker
{
    if (_picker == nil)
    {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, AS_ScreenWidth, 216)];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.backgroundColor = [UIColor yellowColor];
    }
    return _picker;
}

- (UIDatePicker *)datepicker
{
    if (_datepicker == nil)
    {
        _datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, AS_ScreenWidth, 216)];
        _datepicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datepicker;
}

- (UIControl *)hideCtrl
{
    if (_hideCtrl == nil)
    {
        _hideCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - CGRectGetHeight(self.mainView.frame))];
        _hideCtrl.backgroundColor = [UIColor clearColor];
        [_hideCtrl addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hideCtrl;
}

#pragma mark - UIPickerViewDelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.titleArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.titleArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.picker reloadAllComponents];
}

- (void)sureBtnClick:(id)sender
{
    
    if (delegate && [delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
    {
        [delegate actionSheet:self didClickButtonByIndex:[self.picker selectedRowInComponent:0]];
    }
    [self.picker reloadAllComponents];
    
}


- (void)doCancel:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        self.mainView.frame = CGRectMake(0,
                                         AS_ScreenHeight,
                                         AS_ScreenWidth,
                                         self.mainView.frame.size.height);
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    self.isShow = NO;
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        self.mainView.frame = CGRectMake(0,
                                    view.frame.size.height - self.mainView.frame.size.height,
                                    view.frame.size.width,
                                    self.mainView.frame.size.height);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)doClick:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(actionSheet:didClickButtonByIndex:)])
    {
        [delegate actionSheet:self didClickButtonByIndex:sender.tag%777];
    }
    
    [self doCancel:nil];
}

- (void)doClickByDatePicker:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(actionSheet:didSelectDate:)]) {
        [delegate actionSheet:self didSelectDate:self.datepicker.date];
    }
    [self doCancel:nil];
}

@end
