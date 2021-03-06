//
//  TorrentDetailsViewController.m
//  irTorrent
//
//  Created by Carlos Ricardo on 6/7/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "TorrentDetailsViewController.h"
#import "Torrent.h"
#import "SVProgressHUD.h"
#import "SystemMacros.h"
#import "RTorrentAPI.h"
#import "NSString+ByteFormatted.h"
#import "AppDelegate.h"

@interface TorrentDetailsViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation TorrentDetailsViewController

#pragma mark - Properties

@synthesize torrentDetails;
@synthesize torrentNameLbl;
@synthesize torrentHashLbl;
@synthesize torrentProgressPV;
@synthesize peersLbl;
@synthesize torrentUrlTV;
@synthesize refreshTimer;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize detailsView;

- (void) setTorrentDetails:(NSArray *)__torrentDetails{
    
    torrentDetails = __torrentDetails;
    [self updateDetailsOfTorrentUI];
}

#pragma mark - Inits, Memory handle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if( ! ((AppDelegate*)[UIApplication sharedApplication].delegate).isiPad )
        self.navigationItem.rightBarButtonItems=
        
            [NSArray arrayWithObjects: 
             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                           target:self 
                                                           action:@selector(triggeredUpdateOfTorrentInfo:)]
             ,nil];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateDetailsOfTorrentUI];

    if( ! ((AppDelegate*)[UIApplication sharedApplication].delegate).isiPad )
        [self startTimer];
    
    detailsView.hidden =  torrentDetails == nil ;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    if( ! ((AppDelegate*)[UIApplication sharedApplication].delegate).isiPad )
        [self stopTimer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.torrentDetails = nil;
    self.masterPopoverController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Timer handle

- (void) stopTimer {
    
    if (refreshTimer) {
        [refreshTimer invalidate];
        self.refreshTimer = nil;
    }
}

- (void) startTimer {

    [self stopTimer];
    
    // set up update timer
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:kDefaultRefreshTime target:self selector:@selector(timedUpdateOfTorrentInfo:) userInfo:nil repeats:YES];    
}

#pragma mark - UI and data Updates

- (void) triggeredUpdateOfTorrentInfo:(UIBarButtonItem*)sender{
    
    [self stopTimer]; // if it's a manual update stop timed updates
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading",@"Loading")];
    [self refetchTorrent:^(id responseObject){
        
        if (responseObject) {
            
            [self updateDetailsOfTorrentUI];
        }
        
        [SVProgressHUD dismiss]; // start timer again
        [self startTimer];
    }];
}

- (void) timedUpdateOfTorrentInfo:(NSTimer*)timer{
    
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;  // MTStatusBarOverlayAnimationShrink
    overlay.detailViewMode = MTDetailViewModeDetailText;         // enable automatic history-tracking and show in detail-view
    overlay.delegate = self;
    overlay.progress = 0.0;
    [overlay postMessage:NSLocalizedString(@"Refreshing Torrent Info.", nil)];

    [self refetchTorrent:^(id responseObject){
        
        if (responseObject) {
            
            [self updateDetailsOfTorrentUI];
        }
        [overlay postImmediateFinishMessage:NSLocalizedString(@"Done", nil) duration:1.5 animated:YES];
        overlay.progress = 1.0;
    }];
}

// TODO: API CALL for updating torrent info - multicall with params
- (void) refetchTorrent:(void (^)(id responseObject)) success{
    
    // api torrentInfo
    [[RTorrentAPI sharedInstance] 
         torrentInfoMulticallWithHash:[torrentDetails objectAtIndex:kHash] 
         andSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.torrentDetails = responseObject;
             success(torrentDetails);
         } 
         andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
             success(nil);
         } ];
}

- (void)updateDetailsOfTorrentUI {
    
    self.torrentNameLbl.text = [torrentDetails objectAtIndex:kName];
    self.torrentHashLbl.text = [torrentDetails objectAtIndex:kHash];
    self.peersLbl.text = [NSString stringWithFormat:@"%@ %@/%@",
                          [[torrentDetails objectAtIndex:kConnectionCurrent] isEqualToString:kStatusSeeding]?@"Seeding to ":@"Leeching from",
                          [torrentDetails objectAtIndex:kPeersConnected],
                          [torrentDetails objectAtIndex:kPeersAccounted]
                          ];
    self.torrentUrlTV.text = [[torrentDetails objectAtIndex:kSizeBytes] formattedBytes]; 
    
    const NSUInteger bytesDone  = [[torrentDetails objectAtIndex:kBytesDone] integerValue];
    const NSUInteger bytesTotal = [[torrentDetails objectAtIndex:kSizeBytes] integerValue];
    // avoid zero division
    if (bytesTotal) {
        self.torrentProgressPV.progress = bytesDone / bytesTotal;
    }
    else{
        self.torrentProgressPV.progress = 0;
    }
    detailsView.hidden =  torrentDetails == nil ;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Torrents", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
