//
//  TSTrackContext.m
//  The context is used to pass data or external dependencies to the component tree.
//
//  Created by Eric Barnes on 10/10/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TSTrackContext.h"

@implementation TSTrackContext

- (UIImage *)imageWithURL:(NSString *)url {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [[UIImage alloc] initWithData:data];
}

@end
