//
//  SystemMacros.h
//  irTorrent
//
//  Created by Carlos Ricardo on 3/8/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#ifndef irTorrent_SystemMacros_h
#define irTorrent_SystemMacros_h

#define CMLog(format, ...) NSLog(@"%s %d:%@", __PRETTY_FUNCTION__, __LINE__ ,[NSString stringWithFormat:format, ## __VA_ARGS__]);


#endif
