//
//  TSLoginViewController.h
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSLoginViewControllerDelegate;

@interface TSLoginViewController : UIViewController

@property (weak) id<TSLoginViewControllerDelegate> delegate;

@end

@protocol TSLoginViewControllerDelegate <NSObject>

@required
- (void)loginViewControllerDidFinish;

@end
