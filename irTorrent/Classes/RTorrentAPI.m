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
@synthesize mainParams;

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
        self.xmlrpc = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",HTTP,user.url,RPC_ALIAS] ];
        self.client = [AFXMLRPCClient clientWithXMLRPCEndpoint: xmlrpc];
        
        // build a "main" parameters array - pass nil instead of hash
        self.mainParams = [self getMainParams];
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
            parameters:[NSArray arrayWithObject:@""]
               success:success
               failure:failure];
}

/**
 @method get the main list for all torrents including info
 @param sucessBlock
 @param failureBlock
 */
- (void) mainListMulticall: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
           andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure{
    
    [client callMethod: d_multicall 
            parameters: [self getMainParams]
               success: success
               failure: failure];
}

/**
 @method get the main list for all torrents including info
 @param sucessBlock
 @param failureBlock
 */
- (void) torrentInfoMulticallWithHash:(NSString*) hash andSuccess: (void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
                andFailure: (void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure{
    [self mainListMulticall:^(AFHTTPRequestOperation *operation, id responseObject) {
        id object= [[responseObject 
                        filteredArrayUsingPredicate:
                            [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",hash]] lastObject];
        success(operation,object);
    }
    andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

- (NSArray*) getMainParams{
    
    return [NSArray arrayWithObjects:
            v_default_view,
            d_get_hash,       
            d_get_name,
            d_get_state,    
            d_get_down_rate,
            d_get_up_rate,
            d_get_peers_connected,
            d_get_peers_not_connected,
            d_get_peers_accounted,
            d_get_bytes_done,
            d_get_up_total,
            d_get_size_bytes,
            d_get_creation_date,
            d_get_left_bytes,
            d_is_complete,
            d_is_active,
            d_is_hash_checking,
            d_get_base_path,
            d_get_base_filename,
            d_get_bitfield,
            d_get_chunk_size,
            d_get_chunks_hashed,
            d_get_completed_bytes,
            d_get_completed_chunks,
            d_get_connection_current,
            d_get_connection_leech,
            d_get_connection_seed,
            d_get_directory,
            d_get_directory_base,
            d_get_down_total,
            d_get_free_diskspace,
            d_get_hashing,
            d_get_hashing_failed,
            d_get_ignore_commands,
            d_get_loaded_file,
            d_get_local_id,
            d_get_local_id_html,
            d_get_max_file_size,
            d_get_max_size_pex,
            d_get_message,
            d_get_peer_exchange,
            d_get_peers_complete,
            d_get_peers_max
            d_get_peers_min,
            d_get_priority,
            d_get_priority_str,
            d_get_ratio,
            d_get_size_chunks,
            d_get_size_files,
            d_get_size_pex,
            d_get_skip_rate,
            d_get_skip_total,
            d_get_state_changed,
            d_get_state_counter,
            d_get_throttle_name,
            d_get_tied_to_file,
            d_get_tracker_focus,
            d_get_tracker_numwant,
            d_get_tracker_size,
            d_get_uploads_max,
            d_is_hash_checked,
            d_is_multi_file,
            d_is_open,
            d_is_pex_active,
            d_is_private , nil];
}

- (NSArray * ) getFileParams:(NSString*) hash{
    
    return [NSArray arrayWithObjects: 
            hash, @"dummy", @"f.get_name=", @"f.get_state=", 
            @"f.get_down_rate=", @"f.get_up_rate=", @"f.get_peers_connected=", 
            @"f.get_peers_not_connected=", @"f.get_peers_accounted=", 
            @"f.get_bytes_done=", @"f.get_up_total=", @"f.get_size_bytes=", 
            @"f.get_creation_date=", @"f.get_left_bytes=", @"f.get_complete=", 
            @"f.is_active=", @"f.is_hash_checking=", 
            @"f.get_base_path=", @"f.get_base_filename=", 
            nil ];
}

@end
