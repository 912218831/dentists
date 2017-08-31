//
//  HWImagePickerWidget.h
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/5/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：选择图片插件  当有选择图片功能的时候，使用此类，button事件直接调用chooseImagePicker方法，实现回调来获取已经选择的图片
//
//  exp:
//
//  imgPickerWidget = HWImagePickerWidget()
//  imgPickerWidget?.delegate = self
//  imgPickerWidget?.actionSheetShowInView = self
//
//  addPicBtn.addTarget(imgPickerWidget, action: "chooseImagePicker", forControlEvents: UIControlEvents.TouchUpInside)
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-17           创建文件
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class HWImagePickerWidget;

@protocol HWImagePickerWidgetDelegate <NSObject>

- (void)imagePickerWidget:(HWImagePickerWidget *)picker didFinishSelectImage:(UIImage *)image;

@end

@interface HWImagePickerWidget : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIViewController *presentViewController;
@property (nonatomic, strong) UIView *actionSheetShowInView;
@property (nonatomic, weak)   id<HWImagePickerWidgetDelegate> delegate;
@property (nonatomic, strong) UIImagePickerController *imgPic;
- (void)chooseImagePicker:(id)sender;

@end
