//
//  LoginRegisterVC.m
//  usergrid-sample-app
//
//  Created by Michael Hayes on 11/7/13.
//  Copyright (c) 2013 MHayes Design. All rights reserved.
//

#import "LoginRegisterVC.h"
#import "User.h"

@interface LoginRegisterVC ()

@end

@implementation LoginRegisterVC
@synthesize email, password, name, registerButton, loginButton, user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)registerUser:(id)sender
{
    [appDelegate.dataClient addUser:self.email.text email:self.email.text name:self.name.text password:self.password.text completionHandler:^(ApigeeClientResponse *response) {
        if ([response completedSuccessfully]) {
            [self processLogin:self.name.text];
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            UIAlertView* regFail = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                              message:@"Something failed on Login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [regFail show];
        }
    }];
    
}

-(IBAction)loginUser:(id)sender
{
    [appDelegate.dataClient logInUser:self.email.text password:self.password.text completionHandler:^(ApigeeClientResponse *response) {
        if ([response completedSuccessfully]) {
            NSLog(@"%@", [[response.response objectForKey:@"user"] objectForKey:@"name"]);
            [self processLogin:[[response.response objectForKey:@"user"] objectForKey:@"name"]];
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            UIAlertView* loginFail = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Something failed on Registration." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [loginFail show];
        }
    }];
}
-(void)processLogin:(NSString*)aUserName
{
    [self.user loginUser:aUserName];
}
@end
