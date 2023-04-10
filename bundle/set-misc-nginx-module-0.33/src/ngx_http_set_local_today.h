#ifndef NGX_HTTP_SET_LOCAL_TODAY_H
#define NGX_HTTP_SET_LOCAL_TODAY_H

#include "ngx_http_set_misc_module.h"

ngx_int_t ngx_http_set_local_today(ngx_http_request_t *r, ngx_str_t *res,
        ngx_http_variable_value_t *v);

ngx_int_t ngx_http_set_formatted_gmt_time(ngx_http_request_t *r, ngx_str_t *res,
        ngx_http_variable_value_t *v);

ngx_int_t ngx_http_set_formatted_local_time(ngx_http_request_t *r,
        ngx_str_t *res, ngx_http_variable_value_t *v);

#endif