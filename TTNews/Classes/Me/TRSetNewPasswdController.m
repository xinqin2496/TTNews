//
//  TRSetNewPasswdController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRSetNewPasswdController.h"
#import "TRLoginViewController.h"
@interface TRSetNewPasswdController ()
/** 电池栏背景 */
@property (nonatomic,strong)UIView *topView;
/** 背景 */
@property (nonatomic,strong)UIView *bgView;
/** 密码框 */
@property (nonatomic,strong)UITextField *passward;
@end

@implementation TRSetNewPasswdController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = kBGColor;
    
    [Factory addBackItemToVC:self];
    self.title = @"设置新密码";
    [self createTextFields];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"控制器销毁了");
}
-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请设置新的密码";
    label.textColor=[UIColor grayColor];
    label.textAlignment= NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    CGRect frame=[UIScreen mainScreen].bounds;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 50)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.passward=[Factory createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"6-20位字母或数字"];
    self.passward.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passward.secureTextEntry=YES;
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"密码";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    
    UIButton *landBtn=[Factory createButtonFrame:CGRectMake(10, self.bgView.frame.size.height+ self.bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"完成" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:15] target:self action:@selector(clickSettingNewPasswdBtn)];
    landBtn.backgroundColor= kRGBA(239, 73, 83, 0.8);
    landBtn.layer.cornerRadius=5.0f;
    
    [self.bgView addSubview:self.passward];
    
    [self.bgView addSubview:phonelabel];
    [self.view addSubview:landBtn];
}
-(void)clickSettingNewPasswdBtn
{
    if(self.passward.text.length != 0){
        //返回指定的push 过来的界面
    NSArray *temArray = self.navigationController.viewControllers;
    
    for(UIViewController *temVC in temArray){
        
        if ([temVC isKindOfClass:[TRLoginViewController class]]){
           
            [self.navigationController popToViewController:temVC animated:YES];
        }
    }
    }else{
        [self.view showError:@"设置新的密码"];
    }
}

@end
