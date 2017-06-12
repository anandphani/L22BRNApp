//
//  LoginPage.h
//  L22BRNApp
//
//  Created by student on 6/12/17.
//  Copyright © 2017 GAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPage : UIViewController
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginOutlet;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)signupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordOutlet;
- (IBAction)forgotPasswordButton:(id)sender;
@property NSArray * responceArray;
@property NSURLSession * URLSession;
@property NSMutableURLRequest * URLReq;
@property NSURLSessionDataTask * dataTask;
@property NSDictionary * responceDic;
@end
