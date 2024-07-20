#!/usr/bin/env bash
set -x
pkgver_new=$(curl https://portswigger.net/burp/releases | grep community | sed -nE "s/.*professional-community-(.*)\" class=\".*/\1/p" | head -n  1 | tr -d '\n' | tr '-' '.')
sed -Ei "1,\$s|^(pkgver=).*|\1$pkgver_new|" PKGBUILD
updpkgsums ./PKGBUILD
makepkg --printsrcinfo > .SRCINFO
makepkg PKGBUILD --clean --cleanbuild --force

