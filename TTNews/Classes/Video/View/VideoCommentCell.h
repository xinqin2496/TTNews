//
//  VideoCommentCell.h
//  TTNews
//
//  Created by 郑文青 on 16/6/11.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTVideoComment;

@interface VideoCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) TTVideoComment *comment;
-(void)updateToDaySkinMode;
-(void)updateToNightSkinMode;
@end
