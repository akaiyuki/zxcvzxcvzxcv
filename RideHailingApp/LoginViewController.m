//
//  LoginViewController.m
//  RideHailingApp
//
//  Created by AV Dev on 24/07/2017.
//  Copyright © 2017 AV Dev. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@property (nonatomic, strong) UITextField *txtEmail;
@property (nonatomic, strong) UITextField *txtPassword;
@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UITextView *txtTitle;
@property (nonatomic, strong) UITextView *txtSubtitle;
@property (nonatomic, strong) UITextView *txtSignup;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation LoginViewController


-(void)viewDidLoad{
    
}

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 600, 800)];
    [imageView setImage:[UIImage imageNamed:@"background.jpg"]];
    [self.view addSubview:imageView]; // edited for syntax
    
    //toolbar sample
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                  target:nil action:nil];
//    
//    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:
//                          CGRectMake(0, 0, 450, 70)];
//    [toolbar setBarStyle:UIBarStyleBlackOpaque];
//    [self.view addSubview:toolbar];
    
    //end
    
    //image logo
    CGFloat xCenter = [UIScreen mainScreen].bounds.size.width/2 - 100/2;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/2 - 100/2;
    
     self.imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(xCenter, 80, 100, 100)];
    [self.imgLogo setImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:self.imgLogo];
    
    self.txtTitle = [[UITextView alloc] initWithFrame:CGRectMake(xCenter, self.imgLogo.frame.origin.y+100, 300, 100)];
    self.txtTitle.text = @"Ride Hailing";
    self.txtTitle.backgroundColor = [UIColor clearColor];
    self.txtTitle.textColor = [UIColor whiteColor];
    [self.txtTitle setFont:[UIFont fontWithName:@"Arial" size:19]];
    [self.view addSubview:self.txtTitle];
    
    
    
    
    //first row
    self.txtEmail = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 300/2, self.txtTitle.frame.origin.y+70, [UIScreen mainScreen].bounds.size.width/2 + 100, 50)];
    self.txtEmail.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtEmail.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.txtEmail.backgroundColor=[UIColor whiteColor];
    self.txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.txtEmail.placeholder=@"Email Address";
    
    self.txtEmail.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, self.txtTitle.frame.origin.y+70);
    self.txtEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtEmail.textAlignment = NSTextAlignmentCenter;

    
    
    [self.view addSubview:self.txtEmail];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    //second row
    self.txtPassword = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100/2, self.txtEmail.frame.origin.y+75, [UIScreen mainScreen].bounds.size.width/2 + 100, 50)];
    self.txtPassword.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtPassword.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.txtPassword.backgroundColor=[UIColor whiteColor];
    self.txtPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.txtPassword.placeholder=@"Password";
    self.txtPassword.secureTextEntry = YES;
    
    self.txtPassword.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, self.txtEmail.frame.origin.y+90);
    self.txtPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtPassword.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.txtPassword];
    
    
    //button
    
    UIButton *btnReg = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - width/2, self.txtPassword.frame.origin.y+75, width, 40)];
    [btnReg setTitle:@"Login" forState:UIControlStateNormal];
    [btnReg setBackgroundColor: [UIColor greenColor]];
    [btnReg addTarget:self action:@selector(callRequestApi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
    
    
    
    //text sub
    self.txtSubtitle = [[UITextView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 200/2, btnReg.frame.origin.y+75, 200, 100)];
    self.txtSubtitle.text = @"Don't have an account?";
    self.txtSubtitle.backgroundColor = [UIColor clearColor];
    self.txtSubtitle.textColor = [UIColor whiteColor];
    [self.txtSubtitle setFont:[UIFont fontWithName:@"Arial" size:17]];
    //    [self.txtSubtitle addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.txtSubtitle];
    
    //register button
        UIButton *btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(xCenter, self.txtSubtitle.frame.origin.y+20, 100, 40)];
        [btnRegister setTitle:@"Sign Up" forState:UIControlStateNormal];
        [btnRegister setBackgroundColor: [UIColor clearColor]];
    [btnRegister setTitleColor:UIColor.greenColor forState:normal];
        [btnRegister addTarget:self action:@selector(myCustomFunction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    //end
    
    //progress bar
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    self.indicator.center = self.view.center;
    self.indicator.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.indicator];
    [self.indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    //end progress bar
    
    
}

- (void)myCustomFunction:(id)sender{
//    NSLog(@"button was clicked");
    
    MyViewController *controller = [[MyViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)callRequestApi:(id)sender{
    
    [self.indicator startAnimating];

    NSString *baseURL = @"https://av-ridehail.herokuapp.com/login";
        NSDictionary *parameters =  @{@"email": self.txtEmail.text,
                                      @"password": self.txtPassword.text};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        [self.indicator stopAnimating];
        
        MainScreenViewController *controller = [[MainScreenViewController alloc] init];
        [self presentViewController:controller animated:YES completion:nil];
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
//            NSArray *responseArray = responseObject;
            
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *responseDict = responseObject;
            
//            NSDictionary *dictionary = [responseObject valueForKeyPath:@"data"][0];
//            NSString *userId = dictionary[@"_id"];
            
            NSDictionary *dictionary = [responseObject objectForKey:@"data"];
            NSString *userId = dictionary[@"_id"];
            NSString *mobile = dictionary[@"mobile"];
            NSString *name = dictionary[@"name"];
            NSString *email = dictionary[@"email"];
            NSString *time = dictionary[@"time_stamp"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:userId forKey:@"user_id"];
            [defaults setValue:mobile forKey:@"user_mobile"];
            [defaults setValue:name forKey:@"user_name"];
            [defaults setValue:email forKey:@"user_email"];
            [defaults synchronize];
            
            
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [self.indicator stopAnimating];
    }];
    
    
}


//dismiss keyboard
-(void)dismissKeyboard
{
    [self.txtEmail resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}


@end
