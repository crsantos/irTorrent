//
//  TorrentListTableViewController.h
//  irTorrent
//
//  Created by Carlos Ricardo on 6/7/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStatusBarOverlay.h"

@class TorrentDetailsViewController;

@interface TorrentListTableViewController : UITableViewController <MTStatusBarOverlayDelegate, UIActionSheetDelegate>

@property (nonatomic,retain) NSMutableArray*    torrentList;
@property (nonatomic,retain) NSTimer*           refreshTimer;
@property (nonatomic,retain) UIActionSheet*     actionSheet_;
@property (nonatomic,readwrite) BOOL allowed;
@property (strong, nonatomic) TorrentDetailsViewController *detailViewController;
@property (strong, nonatomic) NSIndexPath* selectedIndexPath;

#pragma mark - ActionSheets menus

/**
    @method Shows a menu inside an UIActionsheet
    @param the button clicked
 */
- (IBAction) showMenu:(UIBarButtonItem*) sender;

#pragma mark - Timer handle

/**
    @method Stops any active timer
 */
- (void) stopTimer;

/**
    @method Starts the timer that triggers timed updates on torrent details
 */
- (void) startTimer;

#pragma mark - UI and data Updates
/**
    @method UI updates for torrent details
 */
- (void)updateTorrentListUI;

/**
    @method The triggered method via refresh button for invoking updates on torrent details
 */
- (void) triggeredUpdateOfTorrentList:(UIBarButtonItem*)sender;

/**
    @method The timed method for invoking updates on torrent details
 */
- (void) timedUpdateOfTorrentList:(NSTimer*)timer;

/**
    @method Logout method
    @param sender The clicked btn
 */
- (IBAction)logout:(id)sender;

/**
    @method API call to refecth and later update of torrent details 
 */
- (void) refetchTorrents:(void (^)(id responseObject)) success;

@end
