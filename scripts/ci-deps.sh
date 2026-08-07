#!/bin/bash

set -eEuxo pipefail

NGX_GEOIP2_VERSION="$(gh api --paginate repos/leev/ngx_http_geoip2_module/tags --jq '.[].name' | sort -V | tail -n 1)"
HEADERS_MORE_VERSION="$(gh api --paginate repos/openresty/headers-more-nginx-module/tags --jq '.[].name | sub("^v"; "")' | sort -V | tail -n 1)"
NGX_ZSTD_VERSION="$(gh api repos/facebook/zstd/releases/latest --jq '.tag_name | sub("^v"; "")')"

{
    echo "NGX_GEOIP2_VERSION=$NGX_GEOIP2_VERSION"
    echo "HEADERS_MORE_VERSION=$HEADERS_MORE_VERSION"
    echo "NGX_ZSTD_VERSION=$NGX_ZSTD_VERSION"
} \
    >> "$GITHUB_ENV"
