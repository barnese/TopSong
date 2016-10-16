//
//  TSTrackComponent.m
//  Component for an individual track.
//
//  Created by Eric Barnes on 10/10/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TSTrackComponent.h"
#import "TSTrackImageComponent.h"
#import "TSTrack.h"
#import "TSTrackContext.h"

@implementation TSTrackComponent

+ (instancetype)newWithTrack:(TSTrack *)track context:(TSTrackContext *)context {
    return [super newWithComponent:
            [CKInsetComponent
             newWithInsets:{.top = 10, .bottom = 10, .left = 5, .right = 5 }
             component:
             [CKInsetComponent
              newWithInsets:{.left = 5}
              component:
                [CKStackLayoutComponent
                 newWithView:{}
                 size:{}
                 style:{ .direction = CKStackLayoutDirectionHorizontal }
                 children: {
                     {
                         [TSTrackImageComponent
                          newWithImage:[context imageWithURL:[track imageURLForSize:ImageURLSizeSmall]]]
                     },
                     {
                         [CKInsetComponent
                          newWithInsets:{.left = 5}
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
                                      } size:{}]
                                  },
                                  {
                                      [CKLabelComponent newWithLabelAttributes:{
                                          .string = track.artist,
                                          .font = [UIFont fontWithName:@"Helvetica-Bold" size:14],
                                          .color = [UIColor blueColor],
                                      } viewAttributes:{
                                          {@selector(setBackgroundColor:), [UIColor clearColor]}
                                      } size:{}]
                                      
                                  }
                              }]],
                         .flexGrow = YES,
                     },
                     {
                         [CKInsetComponent
                          newWithInsets:{.right = 5, .bottom = 10 }
                          component:
                          [CKLabelComponent
                           newWithLabelAttributes:{
                               .string = [NSString stringWithFormat:@"%lu", track.playCount],
                               .color = [UIColor lightGrayColor],
                               .font = [UIFont fontWithName:@"Helvetica-Bold" size:18]
                           }
                           viewAttributes:{
                               {@selector(setBackgroundColor:), [UIColor clearColor]},
                               {@selector(setUserInteractionEnabled:), @NO},
                           }
                           size:{ }]],
                         .alignSelf = CKStackLayoutAlignSelfEnd, // Right aligned
                     }
                 }
                 ]]]];
}

@end
