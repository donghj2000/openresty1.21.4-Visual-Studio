#ifndef  NDK_REGEX_H
#define  NDK_REGEX_H

#include  <ngx_core.h>

char *  ndk_conf_set_regex_slot                 (ngx_conf_t *cf, ngx_command_t *cmd, void *conf);
char *  ndk_conf_set_regex_caseless_slot        (ngx_conf_t *cf, ngx_command_t *cmd, void *conf);
char *  ndk_conf_set_regex_array_slot           (ngx_conf_t *cf, ngx_command_t *cmd, void *conf);
char *  ndk_conf_set_regex_array_caseless_slot  (ngx_conf_t *cf, ngx_command_t *cmd, void *conf);

#endif
