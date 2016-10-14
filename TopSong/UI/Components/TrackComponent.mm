//
//  TrackComponent.m
//  Component for an individual track.
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
                 [CKStackLayoutComponent
                  newWithView:{}
                  size:{}
                  style:{}
                  children:{
                      {
                          [CKLabelComponent newWithLabelAttributes:{
                              .string = track.title,
                              .font = [UIFont fontWithName:@"Helvetica-Light" size:18],
                              .color = [UIColor blackColor],
                          } viewAttributes:{
                              {@selector(setBackgroundColor:), [UIColor clearColor]}
                          } size:{}],
                          .alignSelf = CKStackLayoutAlignSelfCenter
                      },
                      {
                          [CKLabelComponent newWithLabelAttributes:{
                              .string = track.artist,
                              .font = [UIFont fontWithName:@"Helvetica-Bold" size:14],
                              .color = [UIColor blueColor],
                          } viewAttributes:{
                              {@selector(setBackgroundColor:), [UIColor clearColor]}
                          } size:{}],
                          .alignSelf = CKStackLayoutAlignSelfCenter
                          
                      }
                  }
             ]]];
}

@end
