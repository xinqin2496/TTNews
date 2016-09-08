//
//  AppDelegate.m
//  TTNews
//
//  Created by 郑文青 on 16/5/20.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.

#import "AppDelegate.h"
#import "TTTabBarController.h"
#import "TTConst.h"
#import "MLTransition.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupUserDefaults];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[TTTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    [AVOSCloud setApplicationId:@"Oil6QD37uVWFItCjyuAa9EdC-gzGzoHsz" clientKey:@"iUml8FrUHii90seEhbeU4Efy"];
    //设置友盟分享
    [self setUMSharedAppKey];
    
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //自定义左上角返回按钮,使右滑生效
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    return YES;
}
-(void)setUMSharedAppKey
{
    [UMSocialData setAppKey:K_UM_AppKey];
    //微信
    [UMSocialWechatHandler setWXAppId:K_WX_AppID appSecret:K_WX_AppSecret url:K_Share_Url];
    //朋友圈
    [UMSocialWechatHandler setWXAppId:K_WX_AppID appSecret:K_WX_AppSecret url:K_Share_Url];
    // 新浪
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:K_Sina_AppKey secret:K_Sina_AppSecret RedirectURL:K_Share_Url];
    // QQ
    [UMSocialQQHandler setQQWithAppId:K_QQ_AppId appKey:K_QQ_AppKey url:K_Share_Url];
    // QQ空间
    [UMSocialQQHandler setQQWithAppId:K_QQ_AppId appKey:K_QQ_AppKey url:K_Share_Url];
}

-(void)setupUserDefaults {
    NSString *currentModel = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentSkinModelKey];
    if (currentModel==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:DaySkinModelValue forKey:CurrentSkinModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    BOOL isShakeCanChangeSkin = [[NSUserDefaults standardUserDefaults] boolForKey:IsShakeCanChangeSkinKey];
    if (!isShakeCanChangeSkin) {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:IsShakeCanChangeSkinKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    BOOL isDownLoadNoImageIn3G = [[NSUserDefaults standardUserDefaults] boolForKey:IsDownLoadNoImageIn3GKey];
    if (!isDownLoadNoImageIn3G) {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:IsDownLoadNoImageIn3GKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
//    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:UserNameKey];
//    if (userName==nil) {
//        [[NSUserDefaults standardUserDefaults] setObject:@"TTNews" forKey:UserNameKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    
//    NSString *userSignature = [[NSUserDefaults standardUserDefaults] stringForKey:UserSignatureKey];
//    if (userSignature==nil) {
//        [[NSUserDefaults standardUserDefaults] setObject:@"这个家伙很懒,什么也没有留下" forKey:UserSignatureKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
