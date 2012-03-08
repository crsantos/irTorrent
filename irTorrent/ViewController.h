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

@interface ViewController : UIViewController //<XMLRPCConnectionDelegate>

@property (nonatomic,retain) IBOutlet UILabel * uploadRateLbl;
@property (nonatomic,retain) IBOutlet UILabel * downloadRateLbl;

@end
