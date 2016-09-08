//
//  VideoCommentCell.h
//  TTNews
//
//  Created by 郑文青 on 16/6/7.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTPictureComment;

@interface PictureCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) TTPictureComment *comment;

-(void)updateToDaySkinMode;
-(void)updateToNightSkinMode;

@end
