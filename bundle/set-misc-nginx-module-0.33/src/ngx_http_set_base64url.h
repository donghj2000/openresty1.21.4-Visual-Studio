#ifndef NGX_HTTP_SET_BASE64URL_H
#define NGX_HTTP_SET_BASE64URL_H

#include "ngx_http_set_misc_module.h"

ngx_int_t ngx_http_set_misc_set_encode_base64url(ngx_http_request_t *r,
        ngx_str_t *res, ngx_http_variable_value_t *v);

ngx_int_t ngx_http_set_misc_set_decode_base64url(ngx_http_request_t *r,
        ngx_str_t *res, ngx_http_variable_value_t *v);

#endif