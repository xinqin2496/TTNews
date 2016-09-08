//
//  PlaceholderTextView.h
//  wyh
//
//  Created by 郑文青 on 16/5/31.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property (nonatomic, strong) UILabel * placeHolderLabel;

@property (nonatomic, copy) NSString * placeholder;

@property (nonatomic, strong) UIColor * placeholderColor;

- (void)textChanged:(NSNotification * )notification;

@end
