//
//  MTCustomActionSheet.h
//  etonkids-iphone
//
//  Created by CaiJingPeng on 13-8-6.
//  Copyright (c) 2013年 wpf. All rights reserved.
//

/**
 *	@file   MTCustomActionSheet
 *  @brief  自定义action sheet
 *  @author
 *  @version 2.2
 *  @date   2013-09-03
 */

#import <UIKit/UIKit.h>

typedef enum
{
    SureButtonInputAccessory = 0,
    SureButtonBottom
    
}SureButtonStyle;

@class MTCustomActionSheet;

@protocol MTCustomActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(NSInteger)index;
- (void)actionSheet:(MTCustomActionSheet *)actionSheet didSelectDate:(NSDate *)date;

@end

@interface MTCustomActionSheet : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
{
    
    UIButton *cancelBtn;
    NSInteger count;
    
    UIButton *sureBtn;
}

@property (nonatomic, assign) id<MTCustomActionSheetDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *buttons;

@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, strong) UIDatePicker *datepicker;

@property (nonatomic, strong) UIControl *hideCtrl;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) SureButtonStyle sureButtonStyle;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) NSInteger numberOfRow; // 每行个数


- (id)initWithImages:(NSArray *)imgArr names:(NSArray *)nameArr;

- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithDatePicker:(NSDate *)date;

- (id)initWithCustomPicker:(NSArray *)titles;

/**
 *	@brief  指定显示在某个view上.
 *
 *	@param 	view 	显示的view.
 */
- (void)showInView:(UIView *)view;

- (void)doCancel:(id)sender;


@end
