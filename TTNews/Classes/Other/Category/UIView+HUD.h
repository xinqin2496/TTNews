//
//  UIView+HUD.h
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (HUD)
//忙提示
- (void)showBusyHUD;
//文字提示
-(void)showMessage:(NSString *)message;
//隐藏提示
- (void)hiddenBusyHUD;
//GIF 提示
-(void)showBusyWithGif;
//成功提示
-(void)showSuccess:(NSString *)success;
- (void)showError:(NSString *)error;
-(void)showError:(NSString *)error bgColor:(UIColor *)bgColor;
-(void)showSuccess:(NSString *)success toView:(UIView *)view bgColor:(UIColor *)bgColor;
-(void)showError:(NSString *)error toView:(UIView *)view bgColor:(UIColor *)bgColor;
-(void)showBusyHUDToView:(UIView *)view;
@end












