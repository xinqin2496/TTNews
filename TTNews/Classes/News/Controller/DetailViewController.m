//
//  DetailViewController.m
//  TTNews
//
//  Created by 郑文青 on 16/5/30.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.

#import "DetailViewController.h"
#import <SDImageCache.h>
#import "TTConst.h"
#import "TTJudgeNetworking.h"

@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIView *shadeView;//(页面模式时，用来使页面变暗)

@property (nonatomic, weak) UIButton *collectButton;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UIButton * backbtn;
@property (nonatomic, weak) UIButton * closeItem;
@property (nonatomic,weak) UILabel *titleLb;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([TTJudgeNetworking judge] == NO) {
        [self.view showError:@"无网络连接"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self setupWebView];
    [self initNaviBar];
    [self setupShadeView];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置滑动的时候 naviBar 隐藏
    [self followRollingScrollView:self.webView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view showBusyHUD];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification object:nil];
    [self updateSkinModel];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view hiddenBusyHUD];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[SDImageCache sharedImageCache] clearDisk];
}

#pragma mark --private Method--初始化webView
- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] init];
    self.webView = webView;
    webView.frame = self.view.frame;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:webView];
    [self.view showBusyHUD];
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    webView.contentMode = UIViewContentModeScaleToFill;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)initNaviBar{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW , 30)];
    
    UIButton * backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(-5, 0, 60, 30);
    [backItem setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateNormal];
    [backItem setImage:[UIImage imageNamed:@"返回_默认"] forState:UIControlStateHighlighted];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitle:@"返回" forState:UIControlStateNormal];
    backItem.titleLabel.font = [UIFont systemFontOfSize:14];
    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];
    [backItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedBackItem:) forControlEvents:UIControlEventTouchUpInside];
    self.backbtn = backItem;
    [backView addSubview:backItem];
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(45, 0, 30, 30)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    closeItem.titleLabel.font = [UIFont systemFontOfSize:14];
    [closeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
    self.closeItem = closeItem;
    [backView addSubview:closeItem];
    
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW / 2 - 100, 0, 200 , 30)];
    titleLb.textColor = [UIColor whiteColor];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.font = [UIFont systemFontOfSize:14];
    self.titleLb = titleLb;
    [backView addSubview:titleLb];
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(kScreenW - 30 - 30, 0, 30, 30);
    [collectBtn setImage:[UIImage imageNamed:@"navigationBarItem_favorite_normal"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"navigationBarItem_favorited_normal"] forState:UIControlStateSelected];
    [collectBtn addTarget:self action:@selector(clickCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:collectBtn];
}
-(void)clickCollectBtn:(UIButton *)sender
{
    [self.view showSuccess:@"收藏成功"];
    sender.selected = YES;
}
#pragma mark - clickedBackItem
- (void)clickedBackItem:(UIBarButtonItem *)btn{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        self.closeItem.hidden = NO;
    }else{
        [self clickedCloseItem:nil];
    }
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --private Method--初始化shadeView(页面模式时，用来使页面变暗)
- (void)setupShadeView {
    UIView *shadeView = [[UIView alloc] init];
    self.shadeView = shadeView;
    shadeView.backgroundColor = [UIColor blackColor];
    shadeView.alpha = 0.3;
    shadeView.userInteractionEnabled = NO;
    shadeView.frame = self.webView.bounds;
    [self.webView addSubview:shadeView];
}

#pragma mark -UIWebViewDelegate-将要加载Webview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (self.webView.canGoBack) {
        self.closeItem.hidden = NO;
    }
    return YES;
}

#pragma mark -UIWebViewDelegate-已经开始加载Webview
- (void)webViewDidStartLoad:(UIWebView *)webView {
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
           //执行事件
        [self.view hiddenBusyHUD];
    });
}

#pragma mark -UIWebViewDelegate-已经加载Webview完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view hiddenBusyHUD];
    //显示网页标题
    self.titleLb.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark -UIWebViewDelegate-加载Webview失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
   [self.view hiddenBusyHUD];
}

#pragma mark --private Method--更新皮肤模式 接到模式切换的通知后会调用此方法
- (void)updateSkinModel {
    NSString  *currentSkinModel = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentSkinModelKey];
    if ([currentSkinModel isEqualToString:NightSkinModelValue]) {
        self.view.backgroundColor = [UIColor blackColor];
        self.shadeView.hidden = NO;
    } else {//日间模式
        self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
        self.shadeView.hidden = YES;
    }
}


@end
