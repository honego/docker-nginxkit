#!/bin/bash

# shellcheck disable=all

NGX_VERSION=$(gh api --paginate repos/freenginx/nginx/tags \
    --jq '.[] | select(.name | test("^release-[0-9]+\\.[0-9]+\\.[0-9]+$")) | .name | sub("^release-"; "")' |
    sort -V | tail -n 1)

NGX_GEOIP2_VERSION=$(gh api --paginate repos/leev/ngx_http_geoip2_module/tags --jq '.[].name' | sort -V | tail -n 1)

HEADERS_MORE_VERSION=$(gh api --paginate repos/openresty/headers-more-nginx-module/tags --jq '.[].name | sub("^v"; "")' | sort -V | tail -n 1)

NGX_ZSTD_VERSION=$(gh api repos/facebook/zstd/releases/latest --jq '.tag_name | sub("^v"; "")')
