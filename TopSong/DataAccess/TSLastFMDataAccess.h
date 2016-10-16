//
//  TSLastFMDataAccess.h
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLastFMDataAccess : NSObject

+ (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password
                  success:(void (^)(void))success
                  failure:(void (^)(NSError *))failure;

+ (void)getTopTracksForUserName:(NSString *)userName
                        success:(void (^)(NSArray *))success
                        failure:(void (^)(NSError *))failure;

@end
