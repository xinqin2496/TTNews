//
//  ContentTableViewController.h
//  TTNews
//
//  Created by 郑文青 on 16/5/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.

#import <UIKit/UIKit.h>
@class TTNormalNews;

@interface ContentTableViewController : UITableViewController

@property(nonatomic, strong) TTNormalNews *news;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *channelName;


@end
