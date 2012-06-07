//
//  ViewController.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLRPCRequest.h"
#import "XMLRPCConnectionManager.h"
#import "XMLRPCResponse.h"
#import "Tracker.h"
#import "User.h"
#import "AFXMLRPCClient.h"
#import "RTorrentAPI.h"
#import "NSString+ByteFormatted.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,retain) IBOutlet UILabel * uploadRateLbl;
@property (nonatomic,retain) IBOutlet UILabel * downloadRateLbl;

@property (nonatomic,retain) IBOutlet UITextField * usernameTF;
@property (nonatomic,retain) IBOutlet UITextField * passwordTF;
@property (nonatomic,retain) IBOutlet UITextField * urlTF;

@property (nonatomic,retain) IBOutlet UIView * loginFieldsView;

@property (nonatomic,readwrite) BOOL allowed;


#pragma mark - XMLRPC Calls

- (IBAction) loginUser:(UIButton*) sender;
- (void) updateTorrentList:(void (^)(BOOL success)) successBlock;

@end
