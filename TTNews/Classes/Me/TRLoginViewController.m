//
//  TRLoginViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/8/3.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRRegisterViewController.h"
#import "TRForgetPasswdController.h"
#import "BlocksKit+UIKit.h"
@interface TRLoginViewController ()
/** 电池栏背景 */
@property (nonatomic,strong)UIView *topView;
/** 背景 */
@property (nonatomic,strong)UIView *bgView;
/** 用户名输入框 */
@property (nonatomic,strong)UITextField *userTextField;
/** 密码输入框 */
@property (nonatomic,strong)UITextField *passwdTextField;

@end

@implementation TRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBGColor;
    [Factory addBackItemToVC:self];

    self.title = @"登录";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(clickRegisterBtn)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self createButtons];
    [self createTextFields];
    AVUser *user = [AVUser currentUser];
    self.userTextField.text = user.mobilePhoneNumber;
    self.passwdTextField.text = user.password;
    
}
-(void)clickRegisterBtn
{
    TRRegisterViewController *registerVC = [TRRegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AVUser *user = [AVUser currentUser];
    self.userTextField.text = user.mobilePhoneNumber;
    self.passwdTextField.text = user.password;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"控制器销毁了");
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 100)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.alpha=0.7;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview: self.bgView];
    
    self.userTextField =[Factory createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    
    self.userTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwdTextField=[Factory createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    self.passwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //密文样式
    self.passwdTextField.secureTextEntry=YES;
    
    
    
    UIImageView *userImageView=[Factory createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    UIImageView *pwdImageView=[Factory createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[Factory createImageViewFrame:CGRectMake(20, 50, self.bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [self.bgView addSubview:self.userTextField];
    [self.bgView addSubview:self.passwdTextField];
    
    [self.bgView addSubview:userImageView];
    [self.bgView addSubview:pwdImageView];
    [self.bgView addSubview:line1];
}



-(void)createButtons
{
    UIButton *loginBtn=[Factory createButtonFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:15] target:self action:@selector(clickLoginBtn)];
    loginBtn.backgroundColor= kRGBA(239, 73, 83, 0.9);
    loginBtn.layer.cornerRadius=5.0f;
    
    
    UIButton *forgotPwdBtn=[Factory createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(clickFogetPwd)];
    [self.view addSubview:loginBtn];
   
    [self.view addSubview:forgotPwdBtn];
}
//判断账号和密码是否为空
- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = self.userTextField.text;
    NSString *passwd = self.passwdTextField.text;
   
    if (username.length == 0 || passwd.length == 0 ) {
        ret = YES;
    }
    
    return ret;
}
//点击登录处理
-(void)clickLoginBtn
{
    
    if (![self isEmpty]) {
        
        [self.view showBusyHUD];
        WK(weakSelf);
        [AVUser logInWithMobilePhoneNumberInBackground:self.userTextField.text password:self.passwdTextField.text block:^(AVUser *user, NSError *error) {
            [weakSelf.view hiddenBusyHUD];
            if (!error) {
                [weakSelf.view showSuccess:@"登录成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }else{
                switch (error.code) {
                    case 211:
                        [weakSelf.view showError:@"用户不存在"];
                        break;
                    case 210:
                        [weakSelf.view showError:@"密码错误"];
                        break;
                    default:
                        [weakSelf.view showError:@"登录失败"];
                        break;
                }
                NSLog(@"登录错误信息:%@",error);
            }
        }];
     
        
    }else{
        if(self.userTextField.text.length == 0){
              [self.view showError:@"请输入用户名"];
        }else{
              [self.view showError:@"请输入密码"];
        }
    }
    
}
-(void)clickFogetPwd
{
    TRForgetPasswdController *forgetVC = [TRForgetPasswdController new];
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}



@end
