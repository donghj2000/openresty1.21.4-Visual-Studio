#ifndef  NDK_URI_H
#define  NDK_URI_H

#include  <ngx_core.h>
#include  <ngx_http.h>

u_char *  ndk_map_uri_to_path_add_suffix  (ngx_http_request_t *r, ngx_str_t *path, ngx_str_t *suffix, ngx_int_t dot);

#endif
