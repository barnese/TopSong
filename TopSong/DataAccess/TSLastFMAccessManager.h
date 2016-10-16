//
//  TSLastFMAccessManager.h
//  Singleton containing keys for Last.fm API access.
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <foundation/Foundation.h>

@interface TSLastFMAccessManager : NSObject {
}

@property (nonatomic, retain) NSString *apiKey;
@property (nonatomic, retain) NSString *apiSecret;

+ (id)sharedManager;

@end
