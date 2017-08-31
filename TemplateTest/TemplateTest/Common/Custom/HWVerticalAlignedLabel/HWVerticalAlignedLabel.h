//
//  HWVerticalAlignedLabel.h
//  TemplateTest
//
//  Created by 龙石华 on 16/5/24.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   用于调节label的显示位置，看顶部，居中，底部显示
 */
typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface HWVerticalAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
