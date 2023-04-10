#ifndef  NDK_HTTP_H
#define  NDK_HTTP_H

#include  <ngx_core.h>
#include  <ngx_http.h>

ngx_uint_t  ndk_http_count_phase_handlers       (ngx_http_core_main_conf_t *cmcf);
ngx_uint_t  ndk_http_parse_request_method       (ngx_str_t *m);

#endif