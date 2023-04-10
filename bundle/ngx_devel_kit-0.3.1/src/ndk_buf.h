#ifndef  NDK_BUF_H
#define  NDK_BUF_H

#include  <ngx_core.h>

ngx_int_t   ndk_copy_chain_to_str   (ngx_pool_t *pool, ngx_chain_t *in, ngx_str_t *str);
char *      ndk_copy_chain_to_charp (ngx_pool_t *pool, ngx_chain_t *in);

#endif