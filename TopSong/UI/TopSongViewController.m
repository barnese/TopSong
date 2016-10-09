//
//  TopSongViewController.m
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TopSongViewController.h"
#import "LastFMDataAccess.h"
#import "LoginViewController.h"

@interface TopSongViewController() <LoginViewControllerDelegate>

@end

@implementation TopSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isUserLoggedIn = [defaults objectForKey:@"IsUserLoggedIn"];
    
    if (!isUserLoggedIn) {
        [self performSelector:@selector(launchLoginViewController) withObject:nil afterDelay:0.5];
    } else {
        [self loadData];
    }
}

- (void)loadData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"UserName"];
    
    [LastFMDataAccess getTopTracksForUserName:userName success:^(NSArray *tracks) {
        NSLog(@"tracks %@", tracks);
    }failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)launchLoginViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *viewController = [storyboard instantiateInitialViewController];
    viewController.delegate = self;
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - LoginViewControllerDelegates

- (void)loginViewControllerDidFinish {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self loadData];
    }];
}

@end
