//
//  MeTableViewController.h
//  TTNews
//
//  Created by 郑文青 on 16/6/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeTableViewControllerDelegate <NSObject>
@optional
- (void)shakeCanChangeSkin:(BOOL)status;

@end

@interface MeTableViewController : UITableViewController

@property(nonatomic, weak) id<MeTableViewControllerDelegate> delegate;
@end
