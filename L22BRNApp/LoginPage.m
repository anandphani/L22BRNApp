//
//  LoginPage.m
//  L22BRNApp
//
//  Created by student on 6/12/17.
//  Copyright © 2017 GAP. All rights reserved.
//

#import "LoginPage.h"
#import "AttendanceView.h"

@interface LoginPage ()

@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"login page created by shvaji");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createElements{
    self.URLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    self.URLReq = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php"]];
    
    
    NSString * dataInStr = [NSString stringWithFormat:@"registeredEmail=%@&registeredPassword=%@&funcName=verifyLogin",self.usernameTF.text,self.passwordTF.text];
    
    NSLog(@"dataInStr is %@",dataInStr);
    
    
    ///////////////////
    
    [self.URLReq setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData *dataToPassToServer = [dataInStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",[dataToPassToServer length]];
    
    [self.URLReq setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    [self.URLReq setHTTPBody:dataToPassToServer];
    
    
    
    /////////////////////////
    self.URLReq.HTTPMethod = @"POST";
    
    
    self.dataTask = [self.URLSession dataTaskWithRequest:self.URLReq completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"server response is %@",self.responceDic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[self.responceDic objectForKey:@"loggedIn"] isEqualToString:@"yes"]) {
               
                AttendanceView*AD=[self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceView"];
                AD.candidateDetailsArray=[[NSMutableArray alloc]init];
                [AD.candidateDetailsArray addObject:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]  objectForKey:@"batchID"]];
                [AD.candidateDetailsArray addObject:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]  objectForKey:@"firstName"]];
                [AD.candidateDetailsArray addObject:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]  objectForKey:@"profileImagePath"]];
                [AD.candidateDetailsArray addObject:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]  objectForKey:@"studentID"]];
                [AD.candidateDetailsArray addObject:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]  objectForKey:@"surName"]];

            }
            else{
            
            
                UIAlertController * alert=[UIAlertController
                                           alertControllerWithTitle:@"Message"
                                           message:[self.responceDic objectForKey:@"msg"]
                                           preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         
                                         
                                     }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                

            
            
            
            }
            
            
        });
        
        
        
    }];
    
    [self.dataTask resume];
    
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(id)sender {
    
    [self createElements];
    
    [self dataTask];
    
    
    
}
- (IBAction)signupButton:(id)sender {
}
- (IBAction)forgotPasswordButton:(id)sender {
}
@end
