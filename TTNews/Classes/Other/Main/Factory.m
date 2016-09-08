//
//  Factory.m
//  TRProject
//
//  Created by jiyingxin on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "Factory.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Factory

+ (BOOL)isPhoneNumber:(NSString *)phoneNum{
    return phoneNum.length == 11 && phoneNum.doubleValue > 10000000000;
}


+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (void)addBackItemToVC:(UIViewController *)vc{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"返回_按下"] forState:UIControlStateHighlighted];
    __block __weak __typeof(&*vc)weakVC = vc;
    [btn bk_addEventHandler:^(id sender) {
        [weakVC.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //弹簧控件, 修复边距
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    vc.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
}


+ (void)addSearchItemToVC:(UIViewController *)vc clickHandler:(void(^)())clickHandler{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"搜索_默认"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"搜索_按下"] forState:UIControlStateHighlighted];
    
    [btn bk_addEventHandler:^(id sender) {
        clickHandler();
    } forControlEvents:UIControlEventTouchUpInside];
    //把视图的边角变为圆形, cornerRadius圆角半径
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //弹簧控件, 修复边距
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    vc.navigationItem.rightBarButtonItems = @[spaceItem,backItem];
    
}
//图片转字符串
+(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
//字符串转图片
+(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
{
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:_encodedImageStr];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}
+(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

+(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}













@end
