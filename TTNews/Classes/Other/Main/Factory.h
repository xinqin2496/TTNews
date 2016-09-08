//
//  Factory.h
//  TRProject
//
//  Created by jiyingxin on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Factory : NSObject
/**
 *  添加返回按钮
 *
 *  @param vc 当前控制器
 */
+ (void)addBackItemToVC:(UIViewController *)vc;
/**
 *  md5 加密
 *
 *  @param str 需要加密的字符串
 *
 *  @return
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  右上角添加搜索按钮
 *
 *  @param vc           当前控制器
 *  @param clickHandler 点击事件
 */
+ (void)addSearchItemToVC:(UIViewController *)vc clickHandler:(void(^)())clickHandler;
/**
 *  是否是电话号码
 *
 *  @param phoneNum 要检测的电话号码
 *
 *  @return
 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNum;
/**
 *  图片转字符串
 *
 *  @param image 
 *
 *  @return
 */
+(NSString *)UIImageToBase64Str:(UIImage *) image;
/**
 *  字符串转图片
 *
 *  @param _encodedImageStr
 *
 *  @return 
 */
+(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;
/**
 *  创建textField
 *
 *  @param frame       frame
 *  @param font        字体
 *  @param placeholder placeholder
 *
 *  @return
 */
+(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder;
/**
 *  创建imageView
 *
 *  @param frame     frame
 *  @param imageName imageName
 *  @param color     color 
 *
 *  @return
 */
+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color;
/**
 *  创建button
 *
 *  @param frame
 *  @param imageName
 *  @param title
 *  @param color
 *  @param font
 *  @param target
 *  @param action
 *
 *  @return
 */
+ (UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action;
@end
