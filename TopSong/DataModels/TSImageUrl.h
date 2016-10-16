//
//  TSImageUrl.h
//  Data model representing an image with URL and size.
//
//  Created by Eric Barnes on 10/8/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TSImageUrlSize) {
    ImageUrlSizeSmall,
    ImageUrlSizeMedium,
    ImageUrlSizeLarge,
    ImageUrlSizeExtraLarge
};

@interface TSImageUrl : NSObject

@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, assign, readonly) TSImageUrlSize size;

- (id)initWithUrl:(NSString *)url size:(TSImageUrlSize)size;

@end
