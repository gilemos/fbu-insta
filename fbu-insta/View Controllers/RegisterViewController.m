//
//  RegisterViewController.m
//  fbu-insta
//
//  Created by gilemos on 7/8/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "RegisterViewController.h"
#import "Parse/Parse.h"


@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation RegisterViewController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setButtonsDesign];
    [self setLabelsDesign];
    [self setBackgoundDesign];
}

#pragma mark - Buttons functions
- (IBAction)tapRegister:(id)sender {
    [self registerUser];
}
- (IBAction)tapReturn:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Design helper methods
- (void)setBackgoundDesign {
    UIImage *backgroundImage = [UIImage imageNamed:@"instagramBackground"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)setButtonsDesign {
    self.registerButton.layer.borderWidth = 0.5f;
    self.registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setLabelsDesign {
    [self.usernameTextField setBackgroundColor:[UIColor clearColor]];
    [self.passwordTextField setBackgroundColor:[UIColor clearColor]];
    [self.emailTextField setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Helper methods
- (void)registerUser {
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
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
