//
//  TrackComponent.h
//  TopSong
//
//  Created by Eric Barnes on 10/10/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

@class Track;
@class TrackContext;

@interface TrackComponent : CKCompositeComponent

+ (instancetype)newWithTrack:(Track *)track context:(TrackContext *)context;

@end
