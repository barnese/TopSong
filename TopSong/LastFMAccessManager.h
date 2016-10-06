//
//  LastFMAccessManager.h
//  Singleton containing keys for Last.fm API access.
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <foundation/Foundation.h>

@interface LastFMAccessManager : NSObject {
}

@property (nonatomic, retain) NSString *clientID;
@property (nonatomic, retain) NSString *clientSecret;

+ (id)sharedManager;

@end
