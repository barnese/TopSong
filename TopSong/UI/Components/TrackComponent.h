//
//  TrackComponent.h
//  TopSong
//
//  Created by Eric Barnes on 10/10/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

// Ignore the documentation warnings caused by ComponentKit.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
#import <ComponentKit/ComponentKit.h>
#pragma clang pop

@class Track;
@class TrackContext;

@interface TrackComponent : CKCompositeComponent

+ (instancetype)newWithTrack:(Track *)track context:(TrackContext *)context;

@end
