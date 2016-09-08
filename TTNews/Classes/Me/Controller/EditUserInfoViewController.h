//
//  EditUserInfoViewController.h
//  TTNews
//
//  Created by 郑文青 on 16/6/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PHOTO_BLOCK)(UIImage *photoImage);

@interface EditUserInfoViewController : UIViewController

-(instancetype)initWithBlock:(PHOTO_BLOCK)block saveImage:(UIImage *)saveImage;

@end
