//
//  TrackComponent.m
//  TopSong
//
//  Created by Eric Barnes on 10/10/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TrackComponent.h"
#import "Track.h"
#import "TrackContext.h"

@implementation TrackComponent

+ (instancetype)newWithTrack:(Track *)track context:(TrackContext *)context {
    return [super newWithComponent:
            [CKInsetComponent
             newWithInsets:{.top = 10, .bottom = 10, .left = 5, .right = 5 }
             component:
                [CKLabelComponent newWithLabelAttributes:{
                    .string = track.title,
                    .font = [UIFont fontWithName:@"Baskerville" size:20],
                    .color = [UIColor blackColor],
                } viewAttributes:{
                    {@selector(setBackgroundColor:), [UIColor clearColor]}
                } size:{}]]];
}

@end
