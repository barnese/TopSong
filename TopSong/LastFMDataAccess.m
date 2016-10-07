//
//  LastFMDataAccess.m
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "LastFMDataAccess.h"
#import "LastFMAccessManager.h"
#import "NSString+MD5.h"
#import "AFNetworking.h"
#import "KeychainWrapper.h"

#define kLastFMRootURL @"https://ws.audioscrobbler.com/2.0/"

@interface LastFMDataAccess()

// Generates an MD5 hashed signature for Last.fm API calls.
+ (NSString *)generateApiSigForParameters:(NSDictionary *)parameters;

@end

@implementation LastFMDataAccess

+ (NSString *)generateApiSigForParameters:(NSDictionary *)parameters {
    NSMutableString *apiSig = [[NSMutableString alloc] init];
    
    NSArray *sortedKeys = [[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // Format the API signature using keys and values from the parameters dictionary into one concatenated string.
    for (NSString *key in sortedKeys) {
        [apiSig appendString:[NSString stringWithFormat:@"%@%@", key, [parameters objectForKey:key]]];
    }
    
    LastFMAccessManager *lastFM = [LastFMAccessManager sharedManager];
    
    // Append the secret to the signature.
    [apiSig appendString:lastFM.clientSecret];
    
    // MD5 hash the signature.
    return [apiSig md5];
}

+ (void)loginWithUserName:(NSString *)userName
              andPassword:(NSString *)password
                  success:(void (^)(void))success
                  failure:(void (^)(NSError *))failure {
    
    LastFMAccessManager *lastFM = [LastFMAccessManager sharedManager];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters addEntriesFromDictionary:@{@"username": userName,
                                           @"password": password,
                                           @"api_key": lastFM.clientID,
                                           @"method": @"auth.getMobileSession",
                                           }];
    
    // Add the API signature to the parameters.
    NSString *apiSignature = [self generateApiSigForParameters:parameters];
    [parameters setObject:apiSignature forKey:@"api_signature"];

    NSString *url = [NSString stringWithFormat:@"%@?method=auth.getMobileSession&username=%@&password=%@&api_key=%@&api_sig=%@&format=json", kLastFMRootURL, userName, password, lastFM.clientID, apiSignature];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
        
            // Get the session key from the response data.
            NSString *sessionKey = [[responseDict objectForKey:@"session"] objectForKey:@"key"];
            NSString *name = [[responseDict objectForKey:@"session"] objectForKey:@"name"];
            
            // Store the session key in the key chain.
            KeychainWrapper *keychain = [[KeychainWrapper alloc] init];
            
            // Use kSecValueData value type for storing the session key. Note it isn't an Obj-C type, so need to bridge.
            [keychain mySetObject:sessionKey forKey:(__bridge id)kSecValueData];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"IsUserLoggedIn"];
            [defaults setValue:name forKey:@"UserName"];
            [defaults synchronize];
            
            // Yay!
            success();
        } else {
            // TODO: return a custom NSError object.
            NSLog(@"Failed to parse auth.getMobileSession responseObject!");
            failure(nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

@end
