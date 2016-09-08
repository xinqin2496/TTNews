//
//  PictureCommentViewController.h
//  TTNews
//
//  Created by 郑文青 on 16/6/3.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//
#import <UIKit/UIKit.h>

@class TTPicture;

@interface PictureCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) TTPicture *picture;

@end
