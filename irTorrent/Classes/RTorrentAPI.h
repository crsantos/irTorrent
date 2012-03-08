//
//  RTorrentAPI.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFXMLRPCClient.h"
#import "User.h"
#import "SystemMacros.h"

@interface RTorrentAPI : AFXMLRPCClient

@property (readwrite, nonatomic, retain) NSURL *xmlrpc;
@property (readwrite, nonatomic, retain) NSString *username;
@property (readwrite, nonatomic, retain) NSString *password;
@property (readwrite, nonatomic, retain) AFXMLRPCClient *client;

+ (id)sharedInstance;

- (void) downloadRate: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
           andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

- (void) uploadRate: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
         andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

- (void) downloadList: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
           andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

@end
