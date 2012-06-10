//
//  User.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTorrent.h"
#import "Torrent.h"

#define kIRTORRENT_DEFAULT_USER @"kIRTORRENT_DEFAULT_USER"

@interface User : NSObject <NSCoding>

@property (nonatomic,retain) NSString * username;
@property (nonatomic,retain) NSString * password;
@property (nonatomic,retain) NSString * url;

+ (id)current;

+ (User*) loadUser;

+ (BOOL) exists;

+ (void) saveUser;

+ (void) resetUser;

@end
