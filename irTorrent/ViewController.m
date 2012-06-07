//
//  ViewController.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"


@implementation ViewController

@synthesize uploadRateLbl;
@synthesize downloadRateLbl;
@synthesize usernameTF;
@synthesize passwordTF;
@synthesize urlTF;
@synthesize allowed;

@synthesize loginFieldsView;

#pragma mark - 

- (IBAction) loginUser:(UIButton*) sender{
    
    if (usernameTF.text.length && passwordTF.text.length && urlTF.text.length) {
    
        User * user = [User current];
        user.username = usernameTF.text;
        user.password = passwordTF.text;
        user.url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",HTTP,urlTF.text,RPC_ALIAS] ] ;
        [User saveUser];
        
        loginFieldsView.hidden=YES;
        
        [SVProgressHUD showWithStatus:@"Loading"];
        
        [self updateTorrentList:^(BOOL success){
            
            if (success) {
                [SVProgressHUD dismiss];
                [self performSegueWithIdentifier:@"segueEnterTorrentList" sender:nil];
            }
            else{
                [User resetUser];
                loginFieldsView.hidden=NO;
                [SVProgressHUD dismissWithError:@"Could not login"];
            }
            
        }];
    }
    else{
        [SVProgressHUD show];
        [SVProgressHUD dismissWithError:@"Must fill info"];
    }
}

#pragma mark - XMLRPC Calls

- (void) updateTorrentList:(void (^)(BOOL success)) successBlock{
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading",@"Loading")];
    // Call singleton API object
    RTorrentAPI * api = [RTorrentAPI sharedInstance];
    
    // test main download list
    [api mainListMulticall:^(AFHTTPRequestOperation *operation, id responseObject){
        ((AppDelegate*)[UIApplication sharedApplication].delegate).torrentList = responseObject;
        successBlock(YES);
        
    }
                andFailure:^(AFHTTPRequestOperation *operation, NSError *error){
                    successBlock(NO);
                    
                    CMLog(@"ERROR: %@", [error localizedDescription])
                }];   
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
#ifdef DEBUG
    usernameTF.text=@"########";
    passwordTF.text=@"########";
    urlTF.text=@"192.168.1.71";
#endif
    
    if ( [User loadUser] ) {
        
        // there's a user on storage
#ifdef DEBUG
        CMLog(@"User found on storage");
#endif
        loginFieldsView.hidden=YES;
        self.allowed=YES;
    }
    else{
        loginFieldsView.hidden=NO;
        self.allowed=NO;
    }
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
    
    if (allowed) {
        
        [SVProgressHUD showWithStatus:@"Loading"];
        
        [self updateTorrentList:^(BOOL success) {         
            if (success) {
                [SVProgressHUD dismissWithSuccess:@"Updated"];
                [self performSegueWithIdentifier:@"segueEnterTorrentList" sender:nil];
            }
            else{
                [SVProgressHUD dismissWithError:@"Ups..." afterDelay:1];
                loginFieldsView.hidden=NO;
            }
        }];
    }
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

#pragma mark - SEGUE handle

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController respondsToSelector:@selector(setTorrentList:)]) {
        NSArray* torrentList = ((AppDelegate*)[UIApplication sharedApplication].delegate).torrentList;
        [segue.destinationViewController performSelector:@selector(setTorrentList:) withObject:torrentList];
    }
}

#pragma mark - UITextField delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    CMLog(@"LOL- %@", textField)
    if ( usernameTF == textField ) {
        [usernameTF resignFirstResponder];
        [passwordTF becomeFirstResponder];
    }
    else if( passwordTF == textField ){
        [passwordTF resignFirstResponder];
        [urlTF becomeFirstResponder];
    }
    else if( urlTF == textField )
    {
        [urlTF resignFirstResponder];
        [self loginUser:nil];
    }
    return NO;
}

@end
