//
//  LoginRegisterVC.h
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class User;

@interface LoginRegisterVC : UIViewController {
    UITextField* email;
    UITextField* password;
    UITextField* name;
    
    UIButton* loginButton;
    UIButton* registerButton;
    
    AppDelegate *appDelegate;
    
    User* user;
}
@property (nonatomic, strong) IBOutlet UITextField* name;
@property (nonatomic, strong) IBOutlet UITextField* email;
@property (nonatomic, strong) IBOutlet UITextField* password;
@property (nonatomic, strong) IBOutlet UIButton* loginButton;
@property (nonatomic, strong) IBOutlet UIButton* registerButton;
@property (nonatomic, strong) User* user;

-(IBAction)loginUser:(id)sender;
-(IBAction)registerUser:(id)sender;
-(void)processLogin:(ApigeeUser*)aUser;

@end
