//
//  UIView+HUD.m
//  TRProject
//
//  Created by tarena on 16/2/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "UIView+HUD.h"
#import "UIImage+GIF.h"
//超时
#define kTimeOut  30
//弹出提示时长
#define kDuration  1

static NSMutableArray *imageList = nil;

@implementation UIView (HUD)
-(void)showError:(NSString *)error bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:error icon:@"error.png" view:nil color:bgColor];
    });
}
-(void)showSuccess:(NSString *)success toView:(UIView *)view bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:success icon:@"success.png" view:view color:bgColor];
    });
}
-(void)showError:(NSString *)error toView:(UIView *)view bgColor:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:error icon:@"error.png" view:view color:bgColor];
    });
}
-(void)showBusyHUDToView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.userInteractionEnabled = NO;
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSArray *imageNames = @[@"00", @"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09"];
            imageList = [NSMutableArray new];
            for (int i = 0; i< imageNames.count; i++) {
                [imageList addObject:[UIImage imageNamed:imageNames[i]]];
            }
        });
        imageView.animationImages = imageList;
        imageView.animationDuration = 1.0;
        [imageView startAnimating];
        hud.customView = imageView;
        hud.color = [UIColor clearColor];
        [hud hide:YES afterDelay:kTimeOut];
    });
}
-(void)showSuccess:(NSString *)success
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:success icon:@"success.png" view:nil color:nil];
    });
}
- (void)showError:(NSString *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [self show:error icon:@"error.png" view:nil color:nil];
    });
}
- (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view color:(UIColor*)color
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    /********** 自己添加 ************************************/
    hud.color = color;
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:12];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}
- (void)showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        //自定义繁忙视图
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSArray *imageNames = @[@"00", @"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09"];
            imageList = [NSMutableArray new];
            for (int i = 0; i< imageNames.count; i++) {
                [imageList addObject:[UIImage imageNamed:imageNames[i]]];
            }
        });
        imageView.animationImages = imageList;
        imageView.animationDuration = 1.0;
        [imageView startAnimating];
        hud.customView = imageView;
        hud.color = [UIColor clearColor];
        [hud hide:YES afterDelay:kTimeOut];
    });
}
-(void)showBusyWithGif
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        //自定义繁忙视图
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
      
        NSString  *name = @"ani_popover_loading_yz_small.gif";
            
        NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
        
        NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
        imageView.image = [UIImage sd_animatedGIFWithData:imageData];
        hud.customView = imageView;
        hud.color = kNaviBarBGColor;
        [hud hide:YES afterDelay:kTimeOut];
    });
}
- (void)showMessage:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        [hud hide:YES afterDelay:kDuration];
       
    });
}
- (void)hiddenBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}
@end










