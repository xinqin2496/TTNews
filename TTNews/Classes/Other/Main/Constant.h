//
//  Constant.h
//  TRProject
//
//  Created by jiyingxin on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


#define kEaseMobKey @"1660626091#trlive"
//掌淘科技的短信验证
#define kMobSDKAppKey @"15c1ddfc5e89c"
#define kMobSDKAppSecret @"25b93c458c369fd3efc43ab2440662ee"

#define kBaiDuMapKey @"wmyVLnfC1LK3yUGEBkxG5NkS"
// 友盟AppKey
#define K_UM_AppKey    @"579703a6e0f55ac6cc00000c"

/*sina*/
#define K_Sina_AppKey   @"3362597459" //@"3921700954"
#define K_Sina_AppSecret @"f670bf7df76d55a3239150ddc166d926" //@"04b48b094faeb16683c32669824ebdad"
/*QQ*/
#define K_QQ_AppId       @"100424468"
#define K_QQ_AppKey      @"c7394704798a158208a74ab60104f0ba"
/*微信开发者appkey*/
#define K_WX_AppID      @"wx556a4b9401b07558"
#define K_WX_AppSecret  @"efd6c025f4aaa2f231229ffeeeafdeb2"

#define K_Share_Url      @"http://www.umeng.com/social"
//屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
//三原色的设置
#define kRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//Documents文件夹的路径
#define kDocPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
//appdelegate的实例对象
#define kAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//把self转化为 __weak __block的方式, 方便的在block中使用而不导致内存循环应用问题
//在宏中使用 \ 可以换行
#define WK(weakSelf) \
__block __weak __typeof(&*self)weakSelf = self;\

#define kBGColor kRGBA(234,234,234,1)

/** 全局的粉色 */
#define kNaviBarBGColor  kRGBA(226, 64, 73, 1.0)

#define kOrangeColor [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* Constant_h */
