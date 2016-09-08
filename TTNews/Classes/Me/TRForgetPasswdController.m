//
//  TRForgetPasswdController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRForgetPasswdController.h"
#import "TRSetNewPasswdController.h"
@interface TRForgetPasswdController ()
/** 电池栏背景 */
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bgView;
/** 手机号 */
@property (nonatomic,strong)UITextField *phoneTextField;
/** 验证码 */
@property (nonatomic,strong)UITextField *codeTextField;
/** 获取验证码按钮 */
@property (nonatomic,strong)UIButton *codeBtn;
/** 定时时间 */
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@end

@implementation TRForgetPasswdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = kBGColor;
    
    [Factory addBackItemToVC:self];
    self.title = @"找回密码";
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
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
    
    
    CGRect frame=[UIScreen mainScreen].bounds;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 100)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.phoneTextField = [Factory createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"11位手机号"];
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField .keyboardType=UIKeyboardTypeNumberPad;
    
    
    self.codeTextField =[Factory createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"4位数字" ];
    self.codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextField.keyboardType=UIKeyboardTypeNumberPad;

    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentLeft;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    codelabel.text=@"验证码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=NSTextAlignmentLeft;
    codelabel.font=[UIFont systemFontOfSize:14];
    
    
    self.codeBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.bgView.frame.size.width-100-20, 62, 100, 30)];
    
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.codeBtn addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.codeBtn];
    
    UIImageView *line1=[Factory createImageViewFrame:CGRectMake(20, 50, self.bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    UIButton *nextBtn=[Factory createButtonFrame:CGRectMake(10, self.bgView.frame.size.height+ self.bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:15] target:self action:@selector(clickNextBtn)];
    nextBtn.backgroundColor= kRGBA(239, 73, 83, 0.8);
    nextBtn.layer.cornerRadius=5.0f;
    
    
    [self.bgView addSubview:self.phoneTextField];
    [self.bgView addSubview:self.codeTextField];
 
    [self.bgView addSubview:phonelabel];
    [self.bgView addSubview:codelabel];

    [self.bgView addSubview:line1];
    [self.view addSubview:nextBtn];
    
}

- (void)getValidCode:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    if ([self.phoneTextField.text isEqualToString:@""])
    {
        [self.view showError:@"请输入手机号码"];
        return;
    }
    else if (self.phoneTextField.text.length <11)
    {
        [self.view showError:@"请输入正确的手机号码"];
        return;
    }

    [AVUser requestPasswordResetWithPhoneNumber:self.phoneTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            sender.userInteractionEnabled = NO;
            self.timeCount = 60;
          self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        } else {
            NSLog(@"错误码:%@",error);
        }
    }];
}

- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.codeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.codeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", (long)self.timeCount];
        [self.codeBtn setTitle:str forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = NO;
        
    }
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.phoneTextField.text;
    NSString *passwd = self.codeTextField.text;
    
    if (username.length == 0 || passwd.length == 0 ) {
        ret = YES;
    }
    
    return ret;
}
-(void)clickNextBtn
{
//    if (![self isEmpty]) {//注册信息不为空
//        
//        [AVUser requestPasswordResetWithPhoneNumber:self.phoneTextField.text block:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
                TRSetNewPasswdController *newPasswdVC = [TRSetNewPasswdController new];
                
                [self.navigationController pushViewController:newPasswdVC animated:YES];
//            } else {
//                NSLog(@"错误码:%@",error);
//            }
//        }];
//
//        
//
//    }else{
//    
//        [self.view showError:@"信息不能为空"];
//    
//    }

   
}

@end
