//
//  TSTrackImageComponent.h
//  TopSong
//
//  Created by Eric Barnes on 10/15/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

// Ignore the documentation warnings caused by ComponentKit.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
#import <ComponentKit/ComponentKit.h>
#pragma clang pop

@interface TSTrackImageComponent : CKCompositeComponent

+ (instancetype)newWithImage:(UIImage *)backgroundImage;

@end
