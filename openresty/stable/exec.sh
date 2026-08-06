#!/bin/sh

#shellcheck disable=SC2034

RESTY_VERSION=1.31.1.1
RESTY_ZLIB_VERSION=1.3.2

RESTY_OPENSSL_VERSION=3.5.7
RESTY_OPENSSL_PATCH_VERSION=3.5.5
RESTY_OPENSSL_BUILD_OPTIONS="\
    enable-camellia enable-cms enable-fips enable-ktls enable-md2 enable-rc5 enable-rfc3779 enable-seed enable-ssl3 enable-ssl3-method enable-weak-ssl-ciphers \
    "

RESTY_PCRE_VERSION="10.47"
RESTY_PCRE_BUILD_OPTIONS="\
    --disable-bsr-anycrlf --disable-coverage --disable-ebcdic --disable-fuzz-support --disable-jit-sealloc --disable-never-backslash-C --disable-pcre2grep-libbz2 --disable-pcre2grep-libz \
    --disable-pcre2test-libedit --disable-rebuild-chartables --disable-silent-rules --disable-static --disable-valgrind --enable-jit --enable-newline-is-lf --enable-pcre2-8 --enable-pcre2-16 \
    --enable-pcre2-32 --enable-pcre2grep-callout --enable-pcre2grep-callout-fork --enable-pcre2grep-jit --enable-percent-zt --enable-shared --enable-unicode \
    "

RESTY_CONFIG_OPTIONS="\
    `# options directly inherited from nginx.` \
    --prefix=/usr/local/openresty \
    --sbin-path=/usr/sbin/openresty \
    --modules-path=/usr/lib/openresty/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/openresty/error.log \
    --pid-path=/run/nginx.pid \
    --lock-path=/run/nginx.lock \
    --user=nginx \
    --group=nginx \
    --without-select_module \
    --without-poll_module \
    --with-threads \
    --with-file-aio \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_v3_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_auth_request_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_slice_module \
    --with-http_stub_status_module \
    --http-log-path=/var/log/openresty/access.log \
    --http-client-body-temp-path=/var/cache/openresty/client_temp \
    --http-proxy-temp-path=/var/cache/openresty/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/openresty/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/openresty/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/openresty/scgi_temp \
    --with-stream_ssl_module \
    --with-stream_realip_module \
    --with-stream_ssl_preread_module \
    `# openresty specific options.` \
    --without-lua_rds_parser \
    "

RESTY_LUAJIT_OPTIONS="\
    --with-luajit-xcflags='-DLUAJIT_NUMMODE=2 -DLUAJIT_ENABLE_LUA52COMPAT' \
    "

RESTY_PCRE_OPTIONS="\
    --with-pcre-jit \
    "

RESTY_CONFIG_DEPS="\
    --with-pcre \
    --with-cc-opt='-DNGX_LUA_ABORT_AT_PANIC \
        -I/usr/local/openresty/zlib/include \
        -I/usr/local/openresty/openssl3/include \
        -I/usr/local/openresty/pcre2/include' \
    --with-ld-opt='-L/usr/local/openresty/zlib/lib \
        -L/usr/local/openresty/openssl3/lib \
        -L/usr/local/openresty/pcre2/lib \
        -Wl,-rpath,/usr/local/openresty/zlib/lib:/usr/local/openresty/openssl3/lib:/usr/local/openresty/pcre2/lib' \
    "

# ./configure --help

#   --with-no-pool-patch               enable the no-pool patch for debugging memory issues

#   --without-http_echo_module         disable ngx_http_echo_module
#   --without-http_xss_module          disable ngx_http_xss_module
#   --without-http_coolkit_module      disable ngx_http_coolkit_module
#   --without-http_set_misc_module     disable ngx_http_set_misc_module
#   --without-http_form_input_module   disable ngx_http_form_input_module
#   --without-http_encrypted_session_module
#                                      disable ngx_http_encrypted_session_module
#   --without-http_srcache_module      disable ngx_http_srcache_module
#   --without-http_lua_module          disable ngx_http_lua_module
#   --without-http_lua_upstream_module disable ngx_http_lua_upstream_module
#   --without-http_headers_more_module disable ngx_http_headers_more_module
#   --without-http_array_var_module    disable ngx_http_array_var_module
#   --without-http_memc_module         disable ngx_http_memc_module
#   --without-http_redis2_module       disable ngx_http_redis2_module
#   --without-http_redis_module        disable ngx_http_redis_module
#   --without-http_rds_json_module     disable ngx_http_rds_json_module
#   --without-http_rds_csv_module      disable ngx_http_rds_csv_module
#   --without-stream_lua_module        disable ngx_stream_lua_module
#   --without-ngx_devel_kit_module     disable ngx_devel_kit_module
#   --without-stream                   disable TCP/UDP proxy module
#   --without-http_ssl_module          disable ngx_http_ssl_module
#   --without-stream_ssl_module        disable ngx_stream_ssl_module

#   --with-http_iconv_module           enable ngx_http_iconv_module
#   --with-http_drizzle_module         enable ngx_http_drizzle_module
#   --with-http_postgres_module        enable ngx_http_postgres_module

#   --without-lua_cjson                disable the lua-cjson library
#   --without-lua_tablepool            disable the lua-tablepool library (and by consequence, the
#                                      lua-resty-shell library)
#   --without-lua_redis_parser         disable the lua-redis-parser library
#   --without-lua_rds_parser           disable the lua-rds-parser library
#   --without-lua_resty_dns            disable the lua-resty-dns library
#   --without-lua_resty_memcached      disable the lua-resty-memcached library
#   --without-lua_resty_redis          disable the lua-resty-redis library
#   --without-lua_resty_mysql          disable the lua-resty-mysql library
#   --without-lua_resty_upload         disable the lua-resty-upload library
#   --without-lua_resty_upstream_healthcheck
#                                      disable the lua-resty-upstream-healthcheck library
#   --without-lua_resty_string         disable the lua-resty-string library
#   --without-lua_resty_websocket      disable the lua-resty-websocket library
#   --without-lua_resty_limit_traffic  disable the lua-resty-limit-traffic library
#   --without-lua_resty_lock           disable the lua-resty-lock library
#   --without-lua_resty_lrucache       disable the lua-resty-lrucache library
#   --without-lua_resty_signal         disable the lua-resty-signal library (and by consequence,
#                                      the lua-resty-shell library)
#   --without-lua_resty_shell          disable the lua-resty-shell library
#   --without-lua_resty_core           disable the lua-resty-core library
#   --without-lua_resty_rsa            disable the lua-resty-rsa library
#   --without-lua_resty_openssl        disable the lua-resty-openssl library

#   --with-luajit=DIR                  use the external LuaJIT 2.1 installation specified by DIR
#   --with-luajit-xcflags=FLAGS        Specify extra C compiler flags for LuaJIT 2.1
#   --with-luajit-ldflags=FLAGS        Specify extra C linker flags for LuaJIT 2.1
#   --without-luajit-lua52             Turns off the LuaJIT extensions from Lua 5.2 that may break
#                                      backward compatibility
#   --without-luajit-gc64              Turns off the LuaJIT GC64 mode (which is enabled by default
#                                      on x86_64)

#   --with-libdrizzle=DIR              specify the libdrizzle 1.0 (or drizzle) installation prefix
#   --with-libpq=DIR                   specify the libpq (or postgresql) installation prefix
#   --with-pg_config=PATH              specify the path of the pg_config utility
