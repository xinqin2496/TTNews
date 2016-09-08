//
//  VideoCommentViewController.h
//  TTNews
//
//  Created by 郑文青 on 16/6/8.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//
#import <UIKit/UIKit.h>

@class TTVideo;
@class VideoTableViewCell;
@interface VideoCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) TTVideo *backVideo;

@end
