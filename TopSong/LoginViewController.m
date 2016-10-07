//
//  LoginViewController.m
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "LoginViewController.h"
#import "LastFMDataAccess.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonTapped:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)loginButtonTapped:(id)sender {
    NSString *userName = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (userName.length == 0) {
        [self displayErrorMessage:NSLocalizedString(@"Enter your username!", @"Missing username message")];
        return;
    } else if (password.length == 0) {
        [self displayErrorMessage:NSLocalizedString(@"Enter your password!", @"Missing password message")];
        return;
    }

    [LastFMDataAccess loginWithUserName:userName andPassword:password success:^{
        NSLog(@"Success!");
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)displayErrorMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Oops!", @"Oops error message title") message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okay = [UIAlertAction actionWithTitle:NSLocalizedString(@"Okay", @"Okay button text") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:okay];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
