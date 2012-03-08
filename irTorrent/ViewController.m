//
//  ViewController.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize uploadRateLbl;
@synthesize downloadRateLbl;

#pragma mark - XMLRPC Tests

- (void) testXMLRPC{
    
    // Call singleton API object
    RTorrentAPI * api = [RTorrentAPI sharedInstance];
    
    // test download rate
    [api downloadRate:^(AFHTTPRequestOperation *operation, id responseObject) {

#ifdef DEBUG          
        CMLog(@"Download rate: %@", responseObject);
#endif
        downloadRateLbl.text = [NSString stringWithFormat:@"Download rate:\t%@",responseObject];
    }
           andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
#ifdef DEBUG
               CMLog(@"FAILED REQUEST! %@",error);
#endif   
           }
     ];
    
    // test upload rate
    [api uploadRate:^(AFHTTPRequestOperation *operation, id responseObject) {
        
#ifdef DEBUG          
        CMLog(@"Upload rate: %@", responseObject);
#endif
        uploadRateLbl.text = [NSString stringWithFormat:@"Upload rate:\t%@",responseObject];
        
    }
           andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
#ifdef DEBUG
               CMLog(@"FAILED REQUEST! %@",error);
#endif   
           }
     ];
    
    // test download list
    [api downloadList:^(AFHTTPRequestOperation *operation, id responseObject) {
              
        // For each hash, get the torrent
        for (NSString* hash in responseObject) {
            
            [api.client callMethod: @"d.get_name" 
                    parameters:[NSArray arrayWithObject:hash ]
                           success:^(AFHTTPRequestOperation *operation, id responseObject){
                               
                               CMLog(@"Name: %@", responseObject);   
                           }
                            
                           failure:^(AFHTTPRequestOperation *operation, NSError *error){
                               CMLog(@"Estudasses..");
                           }];
            
            [api.client callMethod: @"d.get_up_total"
                        parameters:[NSArray arrayWithObject:hash ]
                           success:^(AFHTTPRequestOperation *operation, id responseObject){
                               NSString* t= responseObject;
                               
                               CMLog(@"Total Uploaded: %@", [t formattedBytes] );
                               
                           }
             
                           failure:^(AFHTTPRequestOperation *operation, NSError *error){
                               CMLog(@"Estudasses..");
                           }];
            
        }
    }
         andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
#ifdef DEBUG
             CMLog(@"FAILED REQUEST! %@",error);
#endif   
         }
     ];
}


#pragma mark - Memory warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ( [User loadUser] ) {
        
        // there's a user on storage
        NSLog(@"User found on storage");
    }
    else{

        NSLog(@"INIT user");
        User * user = [User current];
        user.username = @"#########";
        user.password = @"#########";
        user.url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",HTTP,@"192.168.1.71",RPC_ALIAS] ] ;
        
        [User saveUser];
    }
    
    [self testXMLRPC];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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

@end
