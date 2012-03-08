//
//  RTorrent.h
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFXMLRPCClient.h"

/*
 Based on https://github.com/cjlucas/rtorrent-python/blob/master/rtorrent/__init__.py
 */

// RETRIEVERS
#define get_download_list @"download_list"
#define get_xmlrpc_size_limit @"get_xmlrpc_size_limit"
#define get_proxy_address @"get_proxy_address"
#define get_split_suffix @"get_split_suffix"
#define get_up_limit @"get_upload_rate"
#define get_max_memory_usage @"get_max_memory_usage"
#define get_max_open_files @"get_max_open_files"
#define get_min_peers_seed @"get_min_peers_seed"
#define get_use_udp_trackers @"get_use_udp_trackers"
#define get_preload_min_size @"get_preload_min_size"
#define get_max_uploads @"get_max_uploads"
#define get_max_peers @"get_max_peers"
#define get_timeout_sync @"get_timeout_sync"
#define get_receive_buffer_size @"get_receive_buffer_size"
#define get_split_file_size @"get_split_file_size"
#define get_dht_throttle @"get_dht_throttle"
#define get_max_peers_seed @"get_max_peers_seed"
#define get_min_peers @"get_min_peers"
#define get_tracker_numwant @"get_tracker_numwant"
#define get_max_open_sockets @"get_max_open_sockets"
#define get_session @"get_session"
#define get_ip @"get_ip"
#define get_scgi_dont_route @"get_scgi_dont_route"
#define get_hash_read_ahead @"get_hash_read_ahead"
#define get_http_cacert @"get_http_cacert"
#define get_dht_port @"get_dht_port"
#define get_handshake_log @"get_handshake_log"
#define get_preload_type @"get_preload_type"
#define get_max_open_http @"get_max_open_http"
#define get_http_capath @"get_http_capath"
#define get_max_downloads_global @"get_max_downloads_global"
#define get_name @"get_name"
#define get_session_on_completion @"get_session_on_completion"
#define get_down_limit @"get_download_rate"
#define get_down_total @"get_down_total"
#define get_up_rate @"get_up_rate"
#define get_hash_max_tries @"get_hash_max_tries"
#define get_peer_exchange @"get_peer_exchange"
#define get_down_rate @"get_down_rate"
#define get_connection_seed @"get_connection_seed"
#define get_http_proxy @"get_http_proxy"
#define get_stats_preloaded @"get_stats_preloaded"
#define get_timeout_safe_sync @"get_timeout_safe_sync"
#define get_hash_interval @"get_hash_interval"
#define get_port_random @"get_port_random"
#define get_directory @"get_directory"
#define get_port_open @"get_port_open"
#define get_max_file_size @"get_max_file_size"
#define get_stats_not_preloaded @"get_stats_not_preloaded"
#define get_memory_usage @"get_memory_usage"
#define get_connection_leech @"get_connection_leech"
#define get_check_hash @"get_check_hash"
#define get_session_lock @"get_session_lock"
#define get_preload_required_rate @"get_preload_required_rate"
#define get_max_uploads_global @"get_max_uploads_global"
#define get_send_buffer_size @"get_send_buffer_size"
#define get_port_range @"get_port_range"
#define get_max_downloads_div @"get_max_downloads_div"
#define get_max_uploads_div @"get_max_uploads_div"
#define get_safe_sync @"get_safe_sync"
#define get_bind @"get_bind"
#define get_up_total @"get_up_total"
#define get_client_version @"system.client_version"
#define get_library_version @"system.library_version"

// MODIFIERS
#define set_http_proxy @"set_http_proxy"
#define set_max_memory_usage @"set_max_memory_usage"
#define set_max_file_size @"set_max_file_size"
#define set_bind @"set_bind" // Set address bind @param arg: ip address     @type arg: str
#define set_up_limit @"set_upload_rate" // Set global upload limit (in bytes)       @param arg: speed limit     @type arg: int
#define set_port_random @"set_port_random"
#define set_connection_leech @"set_connection_leech"
#define set_tracker_numwant @"set_tracker_numwant"
#define set_max_peers @"set_max_peers"
#define set_min_peers @"set_min_peers"
#define set_max_uploads_div @"set_max_uploads_div"
#define set_max_open_files @"set_max_open_files"
#define set_max_downloads_global @"set_max_downloads_global"
#define set_session_lock @"set_session_lock"
#define set_session @"set_session"
#define set_split_suffix @"set_split_suffix"
#define set_hash_interval @"set_hash_interval"
#define set_handshake_log @"set_handshake_log"
#define set_port_range @"set_port_range"
#define set_min_peers_seed @"set_min_peers_seed"
#define set_scgi_dont_route @"set_scgi_dont_route"
#define set_preload_min_size @"set_preload_min_size"
#define set_log_tracker @"set_log.tracker"
#define set_max_uploads_global @"set_max_uploads_global"
#define set_down_limit @"set_download_rate" // Set global download limit (in bytes) @param arg: speed limit     @type arg: int
#define set_preload_required_rate @"set_preload_required_rate"
#define set_hash_read_ahead @"set_hash_read_ahead"
#define set_max_peers_seed @"set_max_peers_seed"
#define set_max_uploads @"set_max_uploads"
#define set_session_on_completion @"set_session_on_completion"
#define set_max_open_http @"set_max_open_http"
#define set_directory @"set_directory"
#define set_http_cacert @"set_http_cacert"
#define set_dht_throttle @"set_dht_throttle"
#define set_hash_max_tries @"set_hash_max_tries"
#define set_proxy_address @"set_proxy_address"
#define set_split_file_size @"set_split_file_size"
#define set_receive_buffer_size @"set_receive_buffer_size"
#define set_use_udp_trackers @"set_use_udp_trackers"
#define set_connection_seed @"set_connection_seed"
#define set_xmlrpc_size_limit @"set_xmlrpc_size_limit"
#define set_xmlrpc_dialect @"set_xmlrpc_dialect"
#define set_safe_sync @"set_safe_sync"
#define set_http_capath @"set_http_capath"
#define set_send_buffer_size @"set_send_buffer_size"
#define set_max_downloads_div @"set_max_downloads_div"
#define set_name @"set_name"
#define set_port_open @"set_port_open"
#define set_timeout_sync @"set_timeout_sync"
#define set_peer_exchange @"set_peer_exchange"
#define set_ip @"set_ip" // @param arg: ip address        @type arg: str
#define set_timeout_safe_sync @"set_timeout_safe_sync"
#define set_preload_type @"set_preload_type"
#define set_check_hash @"set_check_hash" // Enable/Disable hash checking on finished torrents    @param arg: True to enable, False to disable   @type arg: bool

// just testing
//#define fake_method @"get_fake_method"
#define fake_method_dos @"get_fake_method_dos"

#define HTTP @"http://"
#define RPC_ALIAS @"/RPC2"

@interface RTorrent : NSObject

@property (nonatomic,retain) NSMutableArray* torrents;
@property (nonatomic,retain) NSMutableArray* download_list;
@property (nonatomic, readwrite) BOOL connected;


@end
