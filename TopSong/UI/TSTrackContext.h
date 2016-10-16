//
//  TSTrackContext.h
//  The context is used to pass data or external dependencies to the component tree.
//
//  Created by Eric Barnes on 10/10/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTrackContext : NSObject

- (UIImage *)imageWithURL:(NSString *)url;

@end
