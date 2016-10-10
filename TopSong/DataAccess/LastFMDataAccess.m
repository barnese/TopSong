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
#import "Track.h"

@interface LastFMDataAccess()

// Generates an MD5 hashed signature for Last.fm API calls.
+ (NSString *)generateApiSigForParameters:(NSDictionary *)parameters;

@end

NSString *const kLastFMRootURL = @"https://ws.audioscrobbler.com/2.0/";
NSString *const kErrorDomain = @"DataAccess";

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
    [apiSig appendString:lastFM.apiSecret];
    
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
                                           @"api_key": lastFM.apiKey,
                                           @"method": @"auth.getMobileSession",
                                           }];
    
    // Add the API signature to the parameters.
    NSString *apiSignature = [self generateApiSigForParameters:parameters];
    [parameters setObject:apiSignature forKey:@"api_signature"];

    NSString *url = [NSString stringWithFormat:@"%@?method=auth.getMobileSession&username=%@&password=%@&api_key=%@&api_sig=%@&format=json", kLastFMRootURL, userName, password, lastFM.apiKey, apiSignature];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
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
            NSError *error = [NSError errorWithDomain:kErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey: @"Failed to parse auth.getMobileSession responseObject!"}];
            failure(error);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)getTopTracksForUserName:(NSString *)userName
                        success:(void (^)(NSArray *))success
                        failure:(void (^)(NSError *))failure {
    
    LastFMAccessManager *lastFM = [LastFMAccessManager sharedManager];

    NSString *url = [NSString stringWithFormat:@"%@?method=user.gettoptracks&username=%@&limit=10&api_key=%@&format=json",
                     kLastFMRootURL, userName, lastFM.apiKey];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseRoot = responseObject;
            NSArray *responseTrackArray = [[responseRoot objectForKey:@"toptracks"] objectForKey:@"track"];
            
            NSMutableArray *tracks = [[NSMutableArray alloc] init];

            for (NSDictionary *responseTrack in responseTrackArray) {
                NSString *name = [responseTrack objectForKey:@"name"];
                NSString *artist = [[responseTrack objectForKey:@"artist"] objectForKey:@"name"];
                NSString *trackUrl = [responseTrack objectForKey:@"url"];
                NSInteger playCount = [[responseTrack objectForKey:@"playcount"] integerValue];
                NSInteger rank = [[[responseTrack objectForKey:@"@attr"] objectForKey:@"rank"] integerValue];
                
                Track *track = [[Track alloc] initWithTitle:name artist:artist trackUrl:trackUrl playCount:playCount rank:rank];

                NSArray *responseImages = [responseTrack objectForKey:@"image"];
                for (NSDictionary *responseImage in responseImages) {
                    NSString *url = [responseImage objectForKey:@"#text"];
                    NSString *size = [responseImage objectForKey:@"size"];
                    NSInteger imageUrlSize;
                    
                    if ([size isEqualToString:@"small"]) {
                        imageUrlSize = ImageUrlSizeSmall;
                    } else if ([size isEqualToString:@"medium"]) {
                        imageUrlSize = ImageUrlSizeMedium;
                    } else if ([size isEqualToString:@"large"]) {
                        imageUrlSize = ImageUrlSizeLarge;
                    } else if ([size isEqualToString:@"extralarge"]) {
                        imageUrlSize = ImageUrlSizeExtraLarge;
                    }

                    [track addImage:[[ImageUrl alloc] initWithUrl:url size:imageUrlSize]];
                }
                
                [tracks addObject:track];
            }
            
            success(tracks);
        } else {
            NSError *error = [NSError errorWithDomain:kErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Failed to parse top tracks responseObject!"}];
            failure(error);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}

@end
