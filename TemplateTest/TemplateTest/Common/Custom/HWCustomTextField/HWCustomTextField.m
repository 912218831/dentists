//
//  HWCustomTextField.m
//  TemplateTest
//
//  Created by 龙石华 on 12/5/16.
//  Copyright © 2016 caijingpeng.haowu. All rights reserved.
//

#import "HWCustomTextField.h"


@interface HWCustomTextField ()

@end

@implementation HWCustomTextField

//设置默认文字的显示区域
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(15,0,bounds.size.width ,bounds.size.height);
}

//设置文本显示的区域
-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(15,0,bounds.size.width,bounds.size.height);
}

//编辑区域，即光标的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(15,0,bounds.size.width ,bounds.size.height);
}






@end

























