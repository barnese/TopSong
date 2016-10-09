//
//  ImageUrl.m
//  Data model representing an image with URL and size.
//
//  Created by Eric Barnes on 10/8/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "ImageUrl.h"

@implementation ImageUrl

- (id)initWithUrl:(NSString *)url size:(ImageUrlSize)size {
    self = [super init];
    
    if (self) {
        _url = url;
        _size = size;
    }
    
    return self;
}

@end
