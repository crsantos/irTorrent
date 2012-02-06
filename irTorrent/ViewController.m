//
//  ViewController.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

#pragma mark - XMLRPC Tests

- (void) testXMLRPC{
    
    // initial config    
    
    RTorrentAPI * api = [RTorrentAPI sharedInstance];
    
    [api.client callMethod:@"get_download_rate" 
            parameters:nil
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"RESPONSE TYPE: %@", [responseObject class]);
                   
#ifdef DEBUG                        
                   NSLog(@"Parsed response: %@", responseObject);
#endif
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   
                   NSLog(@"FAILED REQUEST! %@",error);
                   
               }];
    
    
    
//    NSURL *URL = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",HTTP,@"192.168.1.71",RPC_ALIAS] ];
//    
//    AFXMLRPCClient *api = [AFXMLRPCClient clientWithXMLRPCEndpoint:URL];
//    
//    //download_list // get_directory // get_session // system.client_version // get_download_rate // 
//    
//    [api callMethod:@"get_download_rate" 
//         parameters:nil
//            success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                NSLog(@"RESPONSE TYPE: %@", [responseObject class]);
//                
//#ifdef DEBUG                        
//                NSLog(@"Parsed response: %@", responseObject);
//#endif
//
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//                NSLog(@"FAILED REQUEST! %@",error);
//                
//            }];

}

//- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
//    
//    if ([response isFault]) {
//        NSLog(@"Fault code: %@", [response faultCode]);
//        
//        NSLog(@"Fault string: %@", [response faultString]);
//    }
//    else{
//        
//        NSLog(@"Parsed response: %@", [response object]);
//    }
//    
//#ifdef DEBUG    
//    NSLog(@"Response body: %@", [response body]);
//#endif
//}
//- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error
//{
//        NSLog(@"FAILED");
//}
//
//- (BOOL)request: (XMLRPCRequest *)request canAuthenticateAgainstProtectionSpace: (NSURLProtectionSpace *)protectionSpace{
//    
//    return YES;
//}

//- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge{
//    NSLog(@"didReceiveAuthenticationChallenge: %@", challenge);
//    
//    
//    if ( challenge.previousFailureCount > 1)
//    {
//        [[XMLRPCConnectionManager sharedManager] closeConnections]; // closes any active connections
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Error"
//                                                        message:@"Too many unsuccessul login attempts." 
//                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alert show];
//        [alert release];
//    }
//    else 
//    {
//        User * user = [User current];
//        // Answer the challenge
//        NSURLCredential *cred = [[[NSURLCredential alloc] initWithUser:user.username password:user.password
//                                                           persistence:NSURLCredentialPersistenceForSession] autorelease];
//        [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
//    }
//    
//}

//- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge{
//            NSLog(@"didCancelAuthenticationChallenge: %@", challenge);
//}


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
        user.username = @"#######";
        user.password = @"#######";
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
