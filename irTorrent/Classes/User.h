//
//  User.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
}

@property (nonatomic,retain) NSString* username;
@property (nonatomic,retain) NSString* password;
@property (nonatomic,retain) NSString* serverUrl;
@property (nonatomic,retain) NSString* serverPort;

+ (id)sharedInstance;

@end
