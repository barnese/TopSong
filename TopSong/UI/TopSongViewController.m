//
//  TopSongViewController.m
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TopSongViewController.h"
#import "LastFMDataAccess.h"

@implementation TopSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"UserName"];

    [LastFMDataAccess getTopTracksForUserName:userName success:^(NSArray *tracks) {
        NSLog(@"tracks %@", tracks);
    }failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
