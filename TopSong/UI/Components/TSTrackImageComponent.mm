//
//  TSTrackImageComponent.m
//  TopSong
//
//  Created by Eric Barnes on 10/15/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TSTrackImageComponent.h"

@implementation TSTrackImageComponent

+ (instancetype)newWithImage:(UIImage *)image {
    return [super newWithComponent:
            [CKComponent newWithView:{
                  [UIImageView class],
                  {
                      {@selector(setImage:), image},
                      {@selector(setContentMode:), @(UIViewContentModeScaleAspectFill)},
                      {@selector(setClipsToBounds:), @YES},
                  }
              }
              size:{40, 40}]];
}

@end
