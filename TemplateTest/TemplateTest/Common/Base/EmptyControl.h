//
//  EmptyControl.h
//  HaoWu
//
//  Created by PengHuang on 13-11-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^removeBtnClicked)(void);

@interface EmptyControl : UIView
{

}
@property (nonatomic,strong)UIImageView *imgview;
- (id)initWithTitle:(NSString*)_text frame:(CGRect)_frame image:(NSString *)image onClick:(removeBtnClicked)_clickBlock;

@end
