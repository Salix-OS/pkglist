#!/bin/sh
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
#
# Frédéric Galusik <fredg (AT) salixos (dot) org>
#
# pkglist.sh
#
# list pkg-slkbuild-source on a single webpage
# http://salix.enialis.net/i486/13.1/source/pkglist.html
#
# TODO: table, style/css
# TODO: simple search engine
# TODO: think about other $arch, $release ...

REPO="http://salix.enialis.net/i486/13.1/source/"
HTML="pkglist.html"
TITLE="SalixOS Packages"

echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">

<head>
    <title>$TITLE</title>
    <meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />
    <link href=\"http://salix.enialis.net/.icons/favicon.ico\"
    type=\"image/ico\" />
</head>
<style type=\"text/css\">
body
{
font-family: Verdana, sans-serif;
font-size: 85%;
padding: 2em;
}

</style>

<body>
<h2>$TITLE</h2>
<hr />
<table with=\"80%\" cellspading=0>
" > $HTML

ls -d */* | sed -e s@^@$REPO@g | sort -f -t / -k 8 | \
while IFS=/ read prot z rep arch rel src cat pkg
    do
        printf "%s: <a href=\"%s//%s/%s/%s/%s/%s/%s/SLKBUILD\">SLKBUILD</a> \
- <a href=\"%s//%s/%s/%s/%s/%s/%s/\">source</a><br \>\n" \
$pkg $prot $rep $arch $rel $src $cat $pkg $prot $rep $arch $rel $src $cat $pkg
    done >> $HTML

printf "
</body>
</html>" >> $HTML


