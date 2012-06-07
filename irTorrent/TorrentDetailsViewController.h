//
//  TorrentDetailsViewController.h
//  irTorrent
//
//  Created by Carlos Ricardo on 6/7/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TorrentDetailsViewController : UIViewController

#pragma mark - Properties
@property (nonatomic,retain) NSArray* torrentDetails;

@property (nonatomic,retain) IBOutlet UILabel*           torrentNameLbl;
@property (nonatomic,retain) IBOutlet UILabel*           torrentHashLbl;
@property (nonatomic,retain) IBOutlet UIProgressView*    torrentProgressPV;
@property (nonatomic,retain) IBOutlet UILabel*           peersLbl;
@property (nonatomic,retain) IBOutlet UITextView*        torrentUrlTV;
@property (nonatomic,retain) NSTimer*                    refreshTimer;

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
 @method API call to refecth and later update of torrent details 
 */
- (void) refetchTorrent:(void (^)(id responseObject)) success;

/**
 @method UI updates for torrent details
 */
- (void)updateDetailsOfTorrentUI;

/**
 @method The triggered method via refresh button for invoking updates on torrent details
 */
- (void) triggeredUpdateOfTorrentInfo:(UIBarButtonItem*)sender;

/**
 @method The timed method for invoking updates on torrent details
 */
- (void) timedUpdateOfTorrentInfo:(NSTimer*)timer;


@end
