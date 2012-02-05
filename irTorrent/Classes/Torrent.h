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

#define is_hash_checked @"d.is_hash_checked"
#define is_hash_checking @"d.is_hash_checking"
#define get_peers_max @"d.get_peers_max"
#define get_tracker_focus @"d.get_tracker_focus"
#define get_skip_total @"d.get_skip_total"
#define get_state @"d.get_state"
#define get_peer_exchange @"d.get_peer_exchange"
#define get_down_rate @"d.get_down_rate"
#define get_connection_seed @"d.get_connection_seed"
#define get_uploads_max @"d.get_uploads_max"
#define get_priority_str @"d.get_priority_str"
#define is_open @"d.is_open"
#define get_peers_min @"d.get_peers_min"
#define get_peers_complete @"d.get_peers_complete"
#define get_tracker_numwant @"d.get_tracker_numwant"
#define get_connection_current @"d.get_connection_current"
#define is_complete @"d.get_complete"
#define get_peers_connected @"d.get_peers_connected"
#define get_chunk_size @"d.get_chunk_size"
#define get_state_counter @"d.get_state_counter"
#define get_base_filename @"d.get_base_filename"
#define get_state_changed @"d.get_state_changed"
#define get_peers_not_connected @"d.get_peers_not_connected"
#define get_directory @"d.get_directory"
#define is_incomplete @"d.incomplete"
#define get_tracker_size @"d.get_tracker_size"
#define is_multi_file @"d.is_multi_file"
#define get_local_id @"d.get_local_id"
#define get_ratio @"d.get_ratio"
#define get_loaded_file @"d.get_loaded_file"
#define get_max_file_size @"d.get_max_file_size"
#define get_size_chunks @"d.get_size_chunks"
#define is_pex_active @"d.is_pex_active"
#define get_hashing @"d.get_hashing"
#define get_bitfield @"d.get_bitfield"
#define get_local_id_html @"d.get_local_id_html"
#define get_connection_leech @"d.get_connection_leech"
#define get_peers_accounted @"d.get_peers_accounted"
#define get_message @"d.get_message"
#define is_active @"d.is_active"
#define get_size_bytes @"d.get_size_bytes"
#define get_ignore_commands @"d.get_ignore_commands"
#define get_creation_date @"d.get_creation_date"
#define get_base_path @"d.get_base_path"
#define get_left_bytes @"d.get_left_bytes"
#define get_size_files @"d.get_size_files"
#define get_size_pex @"d.get_size_pex"
#define is_private @"d.is_private"
#define get_max_size_pex @"d.get_max_size_pex"
#define get_chunks_hashed @"d.get_chunks_hashed"
#define get_priority @"d.get_priority"
#define get_skip_rate @"d.get_skip_rate"
#define get_completed_bytes @"d.get_completed_bytes"
#define get_name @"d.get_name"
#define get_completed_chunks @"d.get_completed_chunks"
#define get_throttle_name @"d.get_throttle_name"
#define get_free_diskspace @"d.get_free_diskspace"
#define get_directory_base @"d.get_directory_base"
#define get_hashing_failed @"d.get_hashing_failed"
#define get_tied_to_file @"d.get_tied_to_file"
#define get_down_total @"d.get_down_total"
#define get_bytes_done @"d.get_bytes_done"
#define get_up_rate @"d.get_up_rate"
#define get_up_total @"d.get_up_total"

#define set_uploads_max @"d.set_uploads_max"
#define set_tied_to_file @"d.set_tied_to_file"
#define set_tracker_numwant @"d.set_tracker_numwant"
#define set_custom @"d.set_custom"
#define set_priority @"d.set_priority"
#define set_peers_max @"d.set_peers_max"
#define set_hashing_failed @"d.set_hashing_failed"
#define set_message @"d.set_message"
#define set_throttle_name @"d.set_throttle_name"
#define set_peers_min @"d.set_peers_min"
#define set_ignore_commands @"d.set_ignore_commands"
#define set_max_file_size @"d.set_max_file_size"
#define set_custom5 @"d.set_custom5"
#define set_custom4 @"d.set_custom4"
#define set_custom2 @"d.set_custom2"
#define set_custom1 @"d.set_custom1"
#define set_custom3 @"d.set_custom3"
#define set_connection_current @"d.set_connection_current"

// Testing purposes
#define fake_method @"d.fake_method"

@interface Torrent : NSObject

@property (nonatomic,retain) NSString* rpc_id;
@property (nonatomic,retain) NSString* info_hash;

@end
