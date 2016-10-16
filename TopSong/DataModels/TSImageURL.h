//
//  TSImageURL.h
//  Data model representing an image with URL and size.
//
//  Created by Eric Barnes on 10/8/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TSImageURLSize) {
    ImageURLSizeSmall,
    ImageURLSizeMedium,
    ImageURLSizeLarge,
    ImageURLSizeExtraLarge
};

@interface TSImageURL : NSObject

@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, assign, readonly) TSImageURLSize size;

- (id)initWithURL:(NSString *)url size:(TSImageURLSize)size;

@end
