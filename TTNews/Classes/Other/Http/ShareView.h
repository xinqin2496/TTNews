//
//  ShareView.h
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/10/26.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
- (void)setShareController:(UIViewController *)VC Content:(NSString *)content Image:(UIImage *)image URL:(NSString *)url Title:(NSString *)title;

@end
