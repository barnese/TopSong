//
//  LastFMAccessManager.m
//  Singleton containing keys for Last.fm API access.
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "LastFMAccessManager.h"

@implementation LastFMAccessManager

+ (id)sharedManager {
    static LastFMAccessManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id)init {
    if (self = [super init]) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
        NSDictionary *configuration = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        self.clientID = configuration[@"LastFmAPI"][@"ClientID"];
        self.clientSecret = configuration[@"LastFmAPI"][@"ClientSecret"];        
    }
    return self;
}

@end
