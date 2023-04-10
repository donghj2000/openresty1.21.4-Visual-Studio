 
/*
 * 2010 (C) Marcus Clyne
*/

#ifndef NDK_H
#define NDK_H

#define     ndk_version     2015
#define     NDK_VERSION     "0.2.15"


#if (NGX_DEBUG)
#ifndef     NDK_DEBUG
#define     NDK_DEBUG 1
#endif
#else
#ifndef     NDK_DEBUG
#define     NDK_DEBUG 0
#endif
#endif

#include    <ndk_config.h>
#include    <ndk_includes.h>

#if !(NDK)
#error At least one module requires the Nginx Development Kit to be compiled with \
the source (add --with-module=/path/to/devel/kit/src to configure command)
#endif

extern  ngx_module_t    ndk_http_module;


#endif
