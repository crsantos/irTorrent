//
//  TorrentListTableViewController.m
//  irTorrent
//
//  Created by Carlos Ricardo on 6/7/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "TorrentListTableViewController.h"
#import "SVPullToRefresh.h"
#import "User.h"
#import "RTorrentAPI.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@implementation TorrentListTableViewController

#pragma mark - Properties

@synthesize torrentList;
@synthesize refreshTimer;

#pragma mark - Inits, Memory handle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
    // remove loginVC from stack
    NSMutableArray* vcs= [self.navigationController.viewControllers mutableCopy];
    [vcs removeObjectAtIndex:0];
    [self.navigationController setViewControllers:vcs];
    
    
    // setup the pull-to-refresh view
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [self stopTimer]; // if it's a manual update stop timed updates
        
        [self refetchTorrents:^(id responseObject) {
            [self.tableView.pullToRefreshView stopAnimating];
            [self startTimer];
        }];
        
    }];        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.torrentList = nil;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startTimer];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self stopTimer];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return torrentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TorrentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text         = [[torrentList objectAtIndex:indexPath.row] objectAtIndex:kName];
    cell.detailTextLabel.text   = [[torrentList objectAtIndex:indexPath.row] objectAtIndex:kHash]; 
    
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // TODO: Call remove torrent here and on callback: remove form source and table
        
        [torrentList removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - SEGUE handle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSArray* torrentDetails = [torrentList objectAtIndex:indexPath.row];
    if ([segue.destinationViewController respondsToSelector:@selector(setTorrentDetails:)]) {
        [segue.destinationViewController performSelector:@selector(setTorrentDetails:) withObject:torrentDetails];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:kDefaultRefreshTime target:self selector:@selector(timedUpdateOfTorrentList:) userInfo:nil repeats:YES];    
}

#pragma mark - UI and data Updates

// TODO: API CALL for updating torrent info - multicall with params
- (void) refetchTorrents:(void (^)(id responseObject)) success{
    
    // api torrentInfo
    // test main download list
    [[RTorrentAPI sharedInstance] mainListMulticall:^(AFHTTPRequestOperation *operation, id responseObject){
        
        ((AppDelegate*)[UIApplication sharedApplication].delegate).torrentList = responseObject;
        self.torrentList = responseObject;
        [self updateTorrentListUI];
        success(responseObject);
    }
                andFailure:^(AFHTTPRequestOperation *operation, NSError *error){
                    success(nil);
                }];
}

- (void)updateTorrentListUI{
    
    [self.tableView reloadData];
}

- (void) triggeredUpdateOfTorrentList:(UIBarButtonItem*)sender{
    
    [self stopTimer]; // if it's a manual update stop timed updates
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading",@"Loading")];
    [self refetchTorrents:^(id responseObject) {
        
        if (responseObject) {
            
            [self updateTorrentListUI];
        }
        
        [SVProgressHUD dismiss]; // start timer again
        [self startTimer];

    }];
}

- (void) timedUpdateOfTorrentList:(NSTimer*)timer{
    CMLog(@"Timed Update!")
    [self refetchTorrents:^(id responseObject) {
        if (responseObject) {
            [self updateTorrentListUI];
        }
    }];
}

@end