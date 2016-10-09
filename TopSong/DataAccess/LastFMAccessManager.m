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
    static LastFMAccessManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
        NSDictionary *configuration = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        self.apiKey = configuration[@"LastFmAPI"][@"APIKey"];
        self.apiSecret = configuration[@"LastFmAPI"][@"APISecret"];
    }
    return self;
}

@end
