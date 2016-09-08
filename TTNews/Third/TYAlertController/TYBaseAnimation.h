//
//  TYBaseAnimation.h
//  TYAlertControllerDemo
//
//  Created by SunYong on 15/9/1.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYAlertController.h"

@interface TYBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) BOOL isPresenting; // present . dismiss

+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting;

// 如果你只想要警惕或actionsheet风格,你可以判断,你不需要返回nil
//  code : 只支持警报风格
//  if (preferredStyle == TYAlertControllerStyleAlert) {
//      return [super alertAnimationIsPresenting:isPresenting];
//  }
//  return nil;
+ (instancetype)alertAnimationIsPresenting:(BOOL)isPresenting preferredStyle:(TYAlertControllerStyle) preferredStyle;


// 覆盖transiton时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

// 覆盖现在的
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

// 覆盖返回的
- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
