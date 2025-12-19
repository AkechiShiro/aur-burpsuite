#!/usr/bin/env bash
set -x

# Get latest version from RSS feed
pkgver_new=$(
  curl -sf "https://portswigger.net/burp/releases/rss" |
  grep -o 'https://portswigger.net/burp/releases/professional-community-[0-9-]\+' |
  sed 's#.*/professional-community-##' |
  sort -V |
  tail -n 1 |
  sed 's/-/./g'
)

echo $pkgver_new > latest_version
sed -Ei "1,\$s|^(pkgver=).*|\1$pkgver_new|" PKGBUILD

updpkgsums ./PKGBUILD
makepkg --printsrcinfo > .SRCINFO
makepkg PKGBUILD --clean --cleanbuild --force

