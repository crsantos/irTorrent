//
//  RTorrentAPI.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "RTorrentAPI.h"

@implementation RTorrentAPI

@synthesize xmlrpc;
@synthesize username;
@synthesize password;
@synthesize client;

static RTorrentAPI *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (RTorrentAPI *)sharedInstance {

    @synchronized(self){
        
        if (sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:NULL] init];
        }
    }
    
    return sharedInstance;
}
// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        
        // Get the current user
        User * user = [User current];
        
        // and his config URL for rtorrent
        self.xmlrpc = user.url;
        self.client = [AFXMLRPCClient clientWithXMLRPCEndpoint: xmlrpc];
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
    [super dealloc];
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [[self sharedInstance] retain];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

// This function is empty, as we don't want to let the user release this object.
- (oneway void)release {
    
}

//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}

#pragma mark - API operations

/**
    @method get the specified requested info
    @param action the info to be requested
    @param sucessBlock
    @param failureBlock
 */
- (void) downloadRate: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
                andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure{
    
    [client callMethod: get_down_rate 
                parameters:nil
                   success:success
                        failure:failure];
}

/**
    @method get the upload rate
    @param sucessBlock
    @param failureBlock
 */
- (void) uploadRate: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
           andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure{
    
    [client callMethod: get_up_rate 
            parameters:nil
               success:success
               failure:failure];
}

/**
 @method get the download list
 @param sucessBlock
 @param failureBlock
 */
- (void) downloadList: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
           andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure{
    
    [client callMethod: get_download_list 
            parameters:nil
               success:success
               failure:failure];
}



@end
