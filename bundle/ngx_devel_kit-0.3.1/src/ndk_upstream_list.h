#ifndef  NDK_UPSTREAM_LIST_H
#define  NDK_UPSTREAM_LIST_H

#include  <ngx_core.h>
#include  <ngx_http.h>

#if (NDK_UPSTREAM_LIST_CMDS)
#else

#define     ndk_http_conf_get_main_conf(cf)   ngx_http_conf_get_module_main_conf (cf, ndk_http_module)
#define     ndk_http_get_main_conf(r)         ngx_http_get_module_main_conf (r, ndk_http_module)

typedef struct {
	ngx_array_t         *upstreams;
} ndk_http_main_conf_t;

typedef struct {
    ngx_str_t       **elts;
    ngx_uint_t        nelts;
    ngx_str_t         name;
} ndk_upstream_list_t;

char *
ndk_upstream_list(ngx_conf_t *cf, ngx_command_t *cmd, void *conf);

ndk_upstream_list_t *
ndk_get_upstream_list (ndk_http_main_conf_t *mcf, u_char *data, size_t len);
#endif

#endif
