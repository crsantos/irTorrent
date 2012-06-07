//
//  Torrent.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright 2012 crsantos.info. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    Based on https://github.com/cjlucas/rtorrent-python/blob/master/rtorrent/torrent.py
 */

#define kDefaultRefreshTime 5

#define kStatusLeeching @"leech"
#define kStatusSeeding  @"seed"

enum{

    kHash = 0,
    kName,
    kState,
    kDownRate,
    kUpRate,
    kPeersConnected,
    kPeersNotConnected,
    kPeersAccounted,
    kBytesDone,
    kUpTotal,
    kSizeBytes,
    kCreationDate,
    kLeftBytes,
    kComplete,
    kIsActive,
    kIsHashChecking,
    kBasePath,
    kBaseFilename,
    kBitField,
    kChunkSize,
    kChunksHashed,
    kCompletedBytes,
    kCompletedChunks,
    kConnectionCurrent,
    kConnectionLeech,
    kConnectionSeed,
    kDirectory,
    kDirectoryBase,
    kDownTotal,
    kFreeDiskspace,
    kHashing,
    kHashingFailed,
    kIgnoreCommands,
    kLoadedFile,
    kLocalId,
    kLocalIdHTML,
    kMaxFileSize,
    kMaxSizePex,
    kMessage,
    kPeerExchange,
    kPeersCompleted,
    kPeersMax,
    kPeersMin,
    kPriority,
    kPriorityStr,
    kRatio,
    kSizeChunks,
    kSizeFiles,
    kSizePex,
    kSkipRate,
    kSkipTotal,
    kStateChanged,
    kStateCounter,
    kThrottleName,
    kTiedToFile,
    kTrackerFocus,
    kTrackerNumWant,
    kTrackerSize,
    kUploadsMax,
    kIsHashChecked,
    kMultiFile,
    kOpen,
    kPexActive,
    kIsPrivate,
    
    kMaxMultiCallParams
};
typedef NSUInteger MulticallMainListOrder;


// RETRIEVERS
#define v_default_view @"default"
#define f_multicall @"f.multicall"
#define d_multicall @"d.multicall"
#define d_is_hash_checked @"d.is_hash_checked="
#define d_is_hash_checking @"d.is_hash_checking="
#define d_get_peers_max @"d.get_peers_max="
#define d_get_tracker_focus @"d.get_tracker_focus="
#define d_get_skip_total @"d.get_skip_total="
#define d_get_state @"d.get_state="
#define d_get_peer_exchange @"d.get_peer_exchange="
#define d_get_down_rate @"d.get_down_rate="
#define d_get_connection_seed @"d.get_connection_seed="
#define d_get_uploads_max @"d.get_uploads_max="
#define d_get_priority_str @"d.get_priority_str="
#define d_is_open @"d.is_open="
#define d_get_peers_min @"d.get_peers_min="
#define d_get_peers_complete @"d.get_peers_complete="
#define d_get_tracker_numwant @"d.get_tracker_numwant="
#define d_get_connection_current @"d.get_connection_current="
#define d_is_complete @"d.get_complete="
#define d_get_peers_connected @"d.get_peers_connected="
#define d_get_chunk_size @"d.get_chunk_size="
#define d_get_state_counter @"d.get_state_counter="
#define d_get_base_filename @"d.get_base_filename="
#define d_get_state_changed @"d.get_state_changed="
#define d_get_peers_not_connected @"d.get_peers_not_connected="
#define d_get_directory @"d.get_directory="
#define d_is_incomplete @"d.incomplete="
#define d_get_tracker_size @"d.get_tracker_size="
#define d_is_multi_file @"d.is_multi_file="
#define d_get_local_id @"d.get_local_id="
#define d_get_ratio @"d.get_ratio="
#define d_get_loaded_file @"d.get_loaded_file="
#define d_get_max_file_size @"d.get_max_file_size="
#define d_get_size_chunks @"d.get_size_chunks="
#define d_is_pex_active @"d.is_pex_active="
#define d_get_hash @"d.get_hash="
#define d_get_hashing @"d.get_hashing="
#define d_get_bitfield @"d.get_bitfield="
#define d_get_local_id_html @"d.get_local_id_html="
#define d_get_connection_leech @"d.get_connection_leech="
#define d_get_peers_accounted @"d.get_peers_accounted="
#define d_get_message @"d.get_message="
#define d_is_active @"d.is_active="
#define d_get_size_bytes @"d.get_size_bytes="
#define d_get_ignore_commands @"d.get_ignore_commands="
#define d_get_creation_date @"d.get_creation_date="
#define d_get_base_path @"d.get_base_path="
#define d_get_left_bytes @"d.get_left_bytes="
#define d_get_size_files @"d.get_size_files="
#define d_get_size_pex @"d.get_size_pex="
#define d_is_private @"d.is_private="
#define d_get_max_size_pex @"d.get_max_size_pex="
#define d_get_chunks_hashed @"d.get_chunks_hashed="
#define d_get_priority @"d.get_priority="
#define d_get_skip_rate @"d.get_skip_rate="
#define d_get_completed_bytes @"d.get_completed_bytes="
#define d_get_name @"d.get_name="
#define d_get_completed_chunks @"d.get_completed_chunks="
#define d_get_throttle_name @"d.get_throttle_name="
#define d_get_free_diskspace @"d.get_free_diskspace="
#define d_get_directory_base @"d.get_directory_base="
#define d_get_hashing_failed @"d.get_hashing_failed="
#define d_get_tied_to_file @"d.get_tied_to_file="
#define d_get_down_total @"d.get_down_total="
#define d_get_bytes_done @"d.get_bytes_done="
#define d_get_up_rate @"d.get_up_rate="
#define d_get_up_total @"d.get_up_total="

// MODIFIERS
#define d_set_uploads_max @"d.set_uploads_max"
#define d_set_tied_to_file @"d.set_tied_to_file"
#define d_set_tracker_numwant @"d.set_tracker_numwant"
#define d_set_custom @"d.set_custom"
#define d_set_priority @"d.set_priority"
#define d_set_peers_max @"d.set_peers_max"
#define d_set_hashing_failed @"d.set_hashing_failed"
#define d_set_message @"d.set_message"
#define d_set_throttle_name @"d.set_throttle_name"
#define d_set_peers_min @"d.set_peers_min"
#define d_set_ignore_commands @"d.set_ignore_commands"
#define d_set_max_file_size @"d.set_max_file_size"
#define d_set_custom5 @"d.set_custom5"
#define d_set_custom4 @"d.set_custom4"
#define d_set_custom2 @"d.set_custom2"
#define d_set_custom1 @"d.set_custom1"
#define d_set_custom3 @"d.set_custom3"
#define d_set_connection_current @"d.set_connection_current"

// Testing purposes
#define d_fake_method @"d.fake_method"

@interface Torrent : NSObject

@property (nonatomic,retain) NSString* rpc_id;
@property (nonatomic,retain) NSString* info_hash;

#pragma mark - RPC Calls
- (void) getDirectory;

@end
