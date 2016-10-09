//
//  Track.h
//  Track data model.
//
//  Created by Eric Barnes on 10/8/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageUrl.h"

@interface Track : NSObject

@property (nonatomic, assign, readonly) NSInteger rank, playCount;
@property (nonatomic, copy, readonly) NSString *title, *artist, *trackUrl;
@property (nonatomic, strong) NSMutableArray *images;

- (id)initWithTitle:(NSString *)title
             artist:(NSString *)artist
           trackUrl:(NSString *)trackUrl
          playCount:(NSInteger)playCount
               rank:(NSInteger)rank;

- (void)addImage:(ImageUrl *)image;

@end
