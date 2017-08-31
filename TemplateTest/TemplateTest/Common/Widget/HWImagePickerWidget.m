//
//  HWImagePickerWidget.m
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/5/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWImagePickerWidget.h"
#import "AppDelegate.h"

@implementation HWImagePickerWidget

@synthesize presentViewController;
@synthesize actionSheetShowInView;
@synthesize delegate;
@synthesize imgPic;

- (id)init
{
    self = [super init];
    if (self)
    {
        AppDelegate *appDel = SHARED_APP_DELEGATE;
        self.presentViewController = appDel.window.rootViewController;
    }
    return self;
}

- (void)chooseImagePicker:(id)sender
{
    if (self.actionSheetShowInView != nil)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
        [actionSheet showInView:self.actionSheetShowInView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        // 拍照
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) //用户关闭了权限
        {
          [Utility showToastWithMessage:@"请在设置-隐私中开启相机权限"];
        }
        else if (authStatus == AVAuthorizationStatusNotDetermined) //第一次使用，则会弹出是否打开权限
        {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted)
                    {
                        self.imgPic = [[UIImagePickerController alloc] init];
                        self.imgPic.sourceType = UIImagePickerControllerSourceTypeCamera;
                        imgPic.delegate = self;
                        [self.presentViewController presentViewController:self.imgPic animated:YES completion:nil];
                    }
                }];

        }
        else if (authStatus == AVAuthorizationStatusAuthorized)
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                self.imgPic = [[UIImagePickerController alloc] init];
                self.imgPic.sourceType = UIImagePickerControllerSourceTypeCamera;
                imgPic.delegate = self;
                [self.presentViewController presentViewController:self.imgPic animated:YES completion:nil];
            }
            else
            {
                [Utility showToastWithMessage:@"相机不可用"];
            }
        }
       
        }else{
                [Utility showToastWithMessage:@"相机不可用"];
        }
    }
    else if (buttonIndex == 1)
    {
        // 相册
        self.imgPic = [[UIImagePickerController alloc] init];
        self.imgPic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPic.delegate = self;
        [self.presentViewController presentViewController:self.imgPic animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (image != nil)
    {
        
        if (delegate != nil && [delegate respondsToSelector:@selector(imagePickerWidget:didFinishSelectImage:)] == YES)
        {
            [delegate imagePickerWidget:self didFinishSelectImage:image];
        }
    }
}

@end
