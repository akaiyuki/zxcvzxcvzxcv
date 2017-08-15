//
//  MyViewController.m
//  RideHailingApp
//
//  Created by AV Dev on 24/07/2017.
//  Copyright © 2017 AV Dev. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (nonatomic, strong) UITextField *txtEmail;
@property (nonatomic, strong) UITextField *txtName;
@property (nonatomic, strong) UITextField *txtMobile;
@property (nonatomic, strong) UITextField *txtPassword;

@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UITextView *txtTitle;


@end

@implementation MyViewController

-(void)viewDidLoad{
    
//    // Get the previous view controller
//    UIViewController *previousVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//    
//    // Create a UIBarButtonItem
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FooBar" style:UIBarButtonItemStyleBordered target:self action:@selector(yourSelector)];
//    
//    // Associate the barButtonItem to the previous view
//    [previousVC.navigationItem setBackBarButtonItem:barButtonItem];
    
}

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 100, 40)];
//    label.text = @"text";
//    
//    [self.view addSubview:label];
    
//    self.view.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 600, 800)];
    [imageView setImage:[UIImage imageNamed:@"background.jpg"]];
    [self.view addSubview:imageView];
    
    CGFloat xCenter = [UIScreen mainScreen].bounds.size.width/2 - 100/2;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/2;
    
    self.imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(xCenter, 50, 100, 100)];
    [self.imgLogo setImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:self.imgLogo];
    
    self.txtTitle = [[UITextView alloc] initWithFrame:CGRectMake(xCenter, self.imgLogo.frame.origin.y+100, 300, 50)];
    self.txtTitle.text = @"Ride Hailing";
    self.txtTitle.backgroundColor = [UIColor clearColor];
    self.txtTitle.textColor = [UIColor whiteColor];
    [self.txtTitle setFont:[UIFont fontWithName:@"Arial" size:19]];
    [self.view addSubview:self.txtTitle];


    
    
    //first row
    self.txtEmail = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 350/2, self.txtTitle.frame.origin.y, [UIScreen mainScreen].bounds.size.width/2 + 100, 50)];
    self.txtEmail.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtEmail.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.txtEmail.backgroundColor=[UIColor whiteColor];
    self.txtEmail.placeholder=@"Email Address";
    self.txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.txtEmail.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, self.txtTitle.frame.origin.y+70);
    self.txtEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtEmail.textAlignment = NSTextAlignmentCenter;

    
    [self.view addSubview:self.txtEmail];
    //end
    
    //tap keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    //end
    
    
    //second row
    self.txtName = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 350/2, self.txtEmail.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width/2 + 100, 50)];
    self.txtName.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.txtName.backgroundColor=[UIColor whiteColor];
    self.txtName.placeholder=@"First / Last Name";
    self.txtName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.txtName.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, self.txtEmail.frame.origin.y+90);
    self.txtName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtName.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.txtName];
    
    //third row
    self.txtMobile = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 350/2, self.txtName.frame.origin.y, [UIScreen mainScreen].bounds.size.width/2 + 100, 50)];
    self.txtMobile.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtMobile.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.txtMobile.backgroundColor=[UIColor whiteColor];
    self.txtMobile.placeholder=@"Mobile Number";
    self.txtMobile.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.txtMobile.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, self.txtName.frame.origin.y+90);
    self.txtMobile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtMobile.textAlignment = NSTextAlignmentCenter;
    
    [self.txtMobile addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:self.txtMobile];
    
    //fourth row
    self.txtPassword = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 350/2, self.txtMobile.frame.origin.y, [UIScreen mainScreen].bounds.size.width/2 + 100, 50)];
    self.txtPassword.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    self.txtPassword.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.txtPassword.backgroundColor=[UIColor whiteColor];
    self.txtPassword.placeholder=@"Password";
    self.txtPassword.secureTextEntry = YES;
    
    self.txtPassword.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, self.txtMobile.frame.origin.y+90);
    self.txtPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.txtPassword.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.txtPassword];
    
    //button
    UIButton *btnReg = [[UIButton alloc] initWithFrame:CGRectMake(xCenter, self.txtPassword.frame.origin.y+75, 100, 40)];
    [btnReg setTitle:@"Register" forState:UIControlStateNormal];
    [btnReg setBackgroundColor: [UIColor greenColor]];
    [btnReg addTarget:self action:@selector(callApiRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
    
    //button login
    UIButton *btnLog = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 300/2, btnReg.frame.origin.y+50, [UIScreen mainScreen].bounds.size.width/2 + 100, 40)];
    [btnLog setTitle:@"Go Back to Login" forState:UIControlStateNormal];
    [btnLog setBackgroundColor: [UIColor clearColor]];
    
    btnLog.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2.0f, btnReg.frame.origin.y+70);
    
    [btnLog addTarget:self action:@selector(callLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLog];
    
    
    
//    UIView *txtview = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 400, 400)];
//    [txtview addSubview:self.txtEmail];
//    [txtview addSubview:self.txtName];
//    [txtview addSubview:self.txtMobile];
//    [txtview addSubview:self.txtPassword];
//    [txtview addSubview:btnReg];
//    [txtview addSubview:btnLog];
//    
//    [self.view addSubview:txtview];
    
}

-(void)callLogin{
    
    NSLog(@"login click");
    
    LoginViewController *controller = [[LoginViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)callApiRegister:(id)sender{
    
    NSString *baseURL = @"https://av-ridehail.herokuapp.com/user/register";
    NSDictionary *parameters =  @{@"email": self.txtEmail.text,
                                  @"name": self.txtName.text,
                                  @"mobile": self.txtMobile.text,
                                  @"password": self.txtPassword.text};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        //dialog
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Successfully Registered!" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            // action 1
//            LoginViewController *controller = [[LoginViewController alloc] init];
//            [self presentViewController:controller animated:YES completion:nil];
//
//        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
            LoginViewController *controller = [[LoginViewController alloc] init];
            [self presentViewController:controller animated:YES completion:nil];

            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        //end dialog

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
    }];
    
    
}


//dismiss keyboard
-(void)dismissKeyboard
{
    [self.txtEmail resignFirstResponder];
    [self.txtName resignFirstResponder];
    [self.txtMobile resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}
//end

//start
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
//end


@end
