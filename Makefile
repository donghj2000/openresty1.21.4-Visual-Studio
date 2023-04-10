DESTDIR ?= /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/

.PHONY: all installinstall clean

all:
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/LuaJIT-2.1-20220411 && $(MAKE) TARGET_STRIP=@: CCDEBUG=-g Q= XCFLAGS='-DLUA_USE_APICHECK -DLUA_USE_ASSERT -DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT' CC='gcc' PREFIX=/luajit
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-cjson-2.1.0.10 && $(MAKE) DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root/include/luajit-2.1 LUA_CMODULE_DIR=/lualib LUA_MODULE_DIR=/lualib CJSON_LDFLAGS="-shared -L/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root -llua51" CJSON_CFLAGS="-g -O -fpic" CC='gcc'
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-redis-parser-0.13 && $(MAKE) DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root/include/luajit-2.1 LUA_LIB_DIR=/lualib LDFLAGS="-shared -L/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root -llua51" CFLAGS="-g -O -Wall" CC='gcc'
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/nginx-1.21.4 && $(MAKE)

install: all
	mkdir -p $(DESTDIR)/
	-cp /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/COPYRIGHT $(DESTDIR)/
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/LuaJIT-2.1-20220411 && cp -rv /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root/* $(DESTDIR)/
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-cjson-2.1.0.10 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root/include/luajit-2.1 LUA_CMODULE_DIR=/lualib LUA_MODULE_DIR=/lualib CJSON_LDFLAGS="-shared -L/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root -llua51" CJSON_CFLAGS="-g -O -fpic" CC='gcc'
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-redis-parser-0.13 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root/include/luajit-2.1 LUA_LIB_DIR=/lualib LDFLAGS="-shared -L/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/luajit-root -llua51" CFLAGS="-g -O -Wall" CC='gcc'
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-dns-0.22 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-memcached-0.16 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-redis-0.30 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-mysql-0.25 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-string-0.15 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-upload-0.10 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-websocket-0.09 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-lock-0.08 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-lrucache-0.11 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-core-0.1.23 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-upstream-healthcheck-0.06 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-resty-limit-traffic-0.08 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/lua-tablepool-0.02 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/lualib INSTALL=/d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/opm-0.0.6 && /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install bin/* $(DESTDIR)/
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/resty-cli-0.28 && /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/install bin/* $(DESTDIR)/
	cp /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/resty.index $(DESTDIR)/
	cp -r /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/pod $(DESTDIR)/
	cd /d/Anaconda3/MyCode/Nginx/openresty-1.21.4.1/bundle/nginx-1.21.4 && $(MAKE) install DESTDIR=$(DESTDIR)
	mkdir -p $(DESTDIR)/site/lualib $(DESTDIR)/site/pod $(DESTDIR)/site/manifest

clean:
	rm -rf build *.exe *.dll openresty-*
