//
//  ShareView.m
//  TYAlertControllerDemo
//
//  Created by tanyang on 15/10/26.
//  Copyright © 2015年 tanyang. All rights reserved.
//

#import "ShareView.h"
#import "UIView+TYAlertView.h"

@interface ShareView()
{
    UIViewController *_shareVC;
    NSString *_content;
    UIImage *_image;
    NSString *_url;
    NSString *_title;
}


@end

@implementation ShareView

- (IBAction)cancleAction:(id)sender {
    //隐藏view
    [self hideView];
}
-(void)setShareController:(UIViewController *)VC Content:(NSString *)content Image:(UIImage *)image URL:(NSString *)url Title:(NSString *)title
{
    _shareVC = VC;
    _content = content;
    _image = image;
    _url = url;
    _title = title;
}
- (IBAction)clickShareBtn:(UIButton *)sender
{
    [self hideView];
    NSString * titleStr =_title;
    NSString * urlStr = _url;
    UIImage  * image = _image;
    NSString * titleContent =  _content;
    
    NSArray *shareType;
    switch (sender.tag) {
        case 50://微信
            
            shareType = @[UMShareToWechatSession];
            [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr;
//              titleStr = [NSString stringWithFormat:@"%@",titleStr];
            [UMSocialData defaultData].extConfig.wechatSessionData.title = titleStr;
            break;
        case 51://朋友圈
            
            shareType = @[UMShareToWechatTimeline];
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = titleStr;
            break;
        case 52://微博
           
            titleStr = [NSString stringWithFormat:@" 【%@】！ 猛戳->>>%@(分享来自@ZWQYY)",titleStr,urlStr];
            shareType = @[UMShareToSina];
            break;
        case 53://QQ
           
            shareType = @[UMShareToQQ];
            [UMSocialData defaultData].extConfig.qqData.url = urlStr;
//            titleStr = [NSString stringWithFormat:@"【%@】",titleStr];
            [UMSocialData defaultData].extConfig.qqData.title = titleStr;
            break;
        case 54://空间
           
            shareType = @[UMShareToQzone];
            [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
            [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
            break;
        case 55://复制链接
            [self creatCopyStr];
            break;
            
        default:
             NSLog(@"程序未安装,请到App Store下载");
            [self showError:@"程序未安装,请到App Store下载"];
            break;
    }
     [self postShareWith:shareType content:titleContent image:image];
}
-(void)creatCopyStr
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];

    [pab setString:_url];
    
    if (pab == nil) {
        [self showError:@"链接复制失败"];
        
    }else{
        [self showSuccess:@"链接复制成功"];
    }
    
    NSLog(@"复制链接:%@",_url);
}
- (void)postShareWith:(NSArray *)type content:(NSString *)content image:(id)image{
    [[UMSocialDataService defaultDataService] postSNSWithTypes:type content:content image:image location:nil urlResource:nil presentedController:_shareVC completion:^(UMSocialResponseEntity *response){
        [self shareFinishWith:response];
    }];
}

- (void)shareFinishWith:(UMSocialResponseEntity *)response{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功！");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self showSuccess:@"分享成功!"];
        });
       
    }else if (response.responseCode == UMSResponseCodeCancel) {
        NSLog(@"取消");
    }else {
        NSLog(@"失败");
    }
}
@end
