//
//  Torrent.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright 2012 crsantos.info. All rights reserved.
//

#import "Torrent.h"

@implementation Torrent

@synthesize rpc_id;
@synthesize info_hash;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
