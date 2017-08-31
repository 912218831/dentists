//
//  EmptyControl.m
//  HaoWu
//
//  Created by PengHuang on 13-11-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "EmptyControl.h"
#import "Utility.h"

@interface EmptyControl() {
    
}

@property (nonatomic,strong) removeBtnClicked btnClickBlock;

@end

@implementation EmptyControl
@synthesize btnClickBlock = _btnClickBlock;

- (id)initWithTitle:(NSString*)_text frame:(CGRect)_frame image:(NSString *)image onClick:(removeBtnClicked)_clickBlock;
 {
    self = [super initWithFrame:_frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _btnClickBlock = [_clickBlock copy];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        bgview.backgroundColor = COLOR_F3F3F3;
        [self addSubview:bgview];
        
        _imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        _imgview.center = CGPointMake((_frame.size.width/2.0)+2, (_frame.size.height/2.0)-50);
        [self addSubview:_imgview];
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = CD_Text99;
        lbl.font = [UIFont fontWithName:FONTNAME size:15.0f];
        lbl.frame = CGRectMake(0, _imgview.frame.size.height + _imgview.frame.origin.y + 10, _frame.size.width, 30);
        lbl.text = _text;
        lbl.textAlignment = NSTextAlignmentCenter;
//        lbl.numberOfLines = 0;
        //[lbl sizeToFit];
        [self addSubview:lbl];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    return self;
}

- (void)btnClick {
    if(_btnClickBlock)
        _btnClickBlock();
}


@end
