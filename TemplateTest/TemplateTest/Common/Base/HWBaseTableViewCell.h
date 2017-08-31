//
//  HWBaseTableViewCell.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWBaseTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString * title;

- (void)drawCellLine;



/**
 *	@brief	获取cell高度
 *
 *	@param 	model
 *
 *	@return	cell高度
 */
+ (float)getCellHeight;


/**
 *	@brief	获取当前cell的identify（默认当前类名）
 *
 *	@return	cell 的identify
 */
+ (NSString *)getCellIdentify;

/**
 *	@brief	初始化subviews
 *
 *	@return	N/A
 */
- (void)initiaContentView;

/**
 *	@brief	给subview赋值
 *
 *	@param 	model
 *
 *	@return	N/A
 */
- (void)fillDataWithModel:(id)model;

@end
