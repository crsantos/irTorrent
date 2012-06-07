//
//  TorrentListTableViewController.h
//  irTorrent
//
//  Created by Carlos Ricardo on 6/7/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TorrentListTableViewController : UITableViewController

@property (nonatomic,retain) NSMutableArray*    torrentList;
@property (nonatomic,retain) NSTimer*           refreshTimer;

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
    @method API call to refecth and later update of torrent details 
 */
- (void) refetchTorrents:(void (^)(id responseObject)) success;

@end
