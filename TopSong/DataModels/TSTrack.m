//
//  TSTrack.m
//  Track data model.
//
//  Created by Eric Barnes on 10/8/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TSTrack.h"

@implementation TSTrack

- (id)initWithTitle:(NSString *)title
             artist:(NSString *)artist
           trackUrl:(NSString *)trackUrl
          playCount:(NSInteger)playCount
               rank:(NSInteger)rank {
    self = [super init];
    
    if (self) {
        _title = title;
        _artist = artist;
        _trackUrl = trackUrl;
        _playCount = playCount;
        _rank = rank;
    }
    
    _images = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)addImage:(TSImageUrl *)image {
    [_images addObject:image];
}

@end
