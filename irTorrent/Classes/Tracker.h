//
//  Tracker.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright 2012 crsantos.info. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Based on https://github.com/cjlucas/rtorrent-python/blob/master/rtorrent/tracker.py
 */

#define is_enabled @"t.is_enabled"
#define get_id @"t.get_id"
#define get_scrape_incomplete @"t.get_scrape_incomplete"
#define is_open @"t.is_open"
#define get_min_interval @"t.get_min_interval"
#define get_scrape_downloaded @"t.get_scrape_downloaded"
#define get_group @"t.get_group"
#define get_scrape_time_last @"t.get_scrape_time_last"
#define get_type @"t.get_type"
#define get_normal_interval @"t.get_normal_interval"
#define get_url @"t.get_url"
#define get_scrape_complete @"t.get_scrape_complete"

// testing
#define fake_method @"t.fake_method"

// MODIFIERS
#define set_enabled @"t.set_enabled"

@interface Tracker : NSObject

@end
