//
//  TopSongCollectionViewController.mm
//  TopSong
//
//  Created by Eric Barnes on 10/6/16.
//  Copyright © 2016 mteric.com. All rights reserved.
//

#import "TopSongCollectionViewController.h"
#import "LastFMDataAccess.h"
#import "LoginViewController.h"
#import "TrackComponent.h"
#import "TrackContext.h"

@interface TopSongCollectionViewController() <CKComponentProvider, UICollectionViewDelegateFlowLayout, LoginViewControllerDelegate>

@end

@implementation TopSongCollectionViewController {
    CKCollectionViewDataSource *_dataSource;
    CKComponentFlexibleSizeRangeProvider *_sizeRangeProvider;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithCollectionViewLayout:layout]) {
        _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    
    // Create the data source and attach the collection view to it.
    TrackContext *context = [[TrackContext alloc] init];
    _dataSource = [[CKCollectionViewDataSource alloc] initWithCollectionView:self.collectionView
                                                 supplementaryViewDataSource:nil
                                                           componentProvider:[self class]
                                                                     context:context
                                                   cellConfigurationFunction:nil];
    
    // Insert the initial section.
    CKArrayControllerSections sections;
    sections.insert(0);
    [_dataSource enqueueChangeset:{sections, {}} constrainedSize:{}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isUserLoggedIn = [defaults objectForKey:@"IsUserLoggedIn"];
    
    if (!isUserLoggedIn) {
        // Send the user to login.
        [self performSelector:@selector(launchLoginViewController) withObject:nil afterDelay:0.5];
    } else {
        // The user is logged in, so fetch their data.
        [self loadData];
    }
}

- (void)loadData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"UserName"];
    
    [LastFMDataAccess getTopTracksForUserName:userName success:^(NSArray *tracks) {
        // Convert the received tracks to a valid changeset.
        CKArrayControllerInputItems items;
        
        for (NSInteger i = 0; i < [tracks count]; i++) {
            items.insert([NSIndexPath indexPathForRow:i inSection:0], tracks[i]);
        }
        
        // Enqueue the tracks to the data source.
        [_dataSource enqueueChangeset:{{}, items} constrainedSize:[_sizeRangeProvider sizeRangeForBoundingSize:self.collectionView.bounds.size]];
        
    }failure:^(NSError *error) {
        NSLog(@"Error: %@", error); // TODO
    }];
}

- (void)launchLoginViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *viewController = [storyboard instantiateInitialViewController];
    viewController.delegate = self;
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - CKComponentProvider

+ (CKComponent *)componentForModel:(Track *)track context:(TrackContext *)context {
    return [TrackComponent newWithTrack:track context:context];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataSource sizeForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [_dataSource announceWillAppearForItemInCell:cell];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [_dataSource announceDidDisappearForItemInCell:cell];
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewControllerDidFinish {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self loadData];
    }];
}

@end
