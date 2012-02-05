//
//  RTorrent.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "RTorrent.h"


@implementation RTorrent

@synthesize url;
@synthesize torrents;
@synthesize download_list;
@synthesize connected;

#pragma mark - Init stuff
- (id)initWithURL:(NSString*) _url
{
    self = [super init];
    if (self) {
        
        if (url) {    
            self.url = _url;
        }
    }
    
    return self;
}

#pragma mark - RPC Calls
/**
    
 */
- (NSMutableArray*) get_torrents{
    
}

@end
