//
//  LoginViewController.m
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@end

@implementation LoginViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundDesign];
    [self setLabelsDesign];
    [self setButtonsDesign];
}

#pragma mark - Buttons/taps Functions
- (IBAction)tapLogin:(id)sender {
    [self loginUser];
}
- (IBAction)tapScreen:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - Design helper methods
-(void)setBackgroundDesign {
    UIImage *backgroundImage = [UIImage imageNamed:@"instagramBackground"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

-(void)setLabelsDesign {
    [self.usernameTextField setBackgroundColor:[UIColor clearColor]];
    [self.passwordTextField setBackgroundColor:[UIColor clearColor]];
}

-(void)setButtonsDesign {
    self.loginButton.layer.borderWidth = 0.5f;
    self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark - Overall helper methods
- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"logedInSegue" sender:self];
        }
    }];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
