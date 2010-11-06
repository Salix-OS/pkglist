#!/bin/sh
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
#
#
# Frédéric Galusik <fredg (AT) salixos (dot) org>
#
# list pkgname-slkbuild-source on a single webpage
#

REPO="http://salix.enialis.net/i486/13.1/source/"
HTML="pkglist32.html"
TITLE="Salix packages list (32bits)"
ARCH2="Salix packages list (64bits)"

# small check & backup
if [ ! -f $HTML ]
    then
        echo "Error, this script have to be run in the source root! Play again!"
        exit 1
    else
        mv $HTML .$HTML.old
fi

# html/css
echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
  \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">

<head>
    <title>$TITLE</title>
    <meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />
    <link href=\"http://salix.enialis.net/.icons/favicon.ico\"
    rel=\"SHORTCUT ICON\" />
</head>
<style type=\"text/css\">
body
{
color: #444444;
margin: 0;
padding: 0;
font-size: 12px;
font-family: Verdana, Helvetica, Arial, sans-serif;
background-color: #656565;
background-image: url(../../../.icons/body.png);
background-repeat: repeat-x;
height:100%; /* needed for container min-height */
}
table {
 border-width:10px;
 border-style:solid;
 border-color:white;
 width:100%;
 background-color: #FFFFFF;
 }
td {
 background-color: #FFFFFF;
 border-width:0px;
 border-bottom:1px;
 border-style:dashed;
 border-color:green;
 width:33%;
 text-align: center;
 }
 #container {
        position:relative; /* needed for footer positioning*/
        margin:0 auto; /* center, not in IE5 */
        width: 100%;
        height:auto !important; /* real browsers */
        height:100%; /* IE6: treaded as min-height*/
        min-height:100%; /* real browsers */
      }
      a, a:visited {
        color: #125298;
        text-decoration: none;
        font-weight: bold;
      }
      a:hover {
        color: #0682E6;
        text-decoration: none;
      }
            img {
                border: none;
            }
      em {
        color: #FD9C19;
        font-weight: bold;
        font-style: normal;
        padding-left: 2px;
        padding-right: 2px;
      }
      em:before {
        content: \"“\";
      }
      em:after {
        content: \"”\";
      }
      #title {
        background-image: url(../../../.icons/logo.gif);
        background-repeat: no-repeat;
        width: 978px;
        height: 100px;
        margin-left: auto;
        margin-right: auto;
      }
      h2 {
        display: none;
      }
      #head {
        display: block;
        margin-top: 20px;
        margin-left: 20px;
        margin-right: 20px;
      }
      #body {
        margin-left: 20px;
        margin-right: 20px;
        padding-bottom: 40px;
      }
      #foot {
        position:absolute;
        width: 100%;
        bottom: 0px; /* stick to bottom */
        background-color: #222222;
        color: #F8F5EC;
        background-repeat: repeat-x;
        height: 40px;
      }
      #foot div {
        text-align: right;
        padding-right: 10px;
        padding-top: 10px;
      }
      .block {
        background-color: #FFFFFF;
        color: black;
        border-width: 1px;
        border-style: solid;
        border-color: #A9A9A9;
      }
      .block .title {
        padding: 8px 3px 8px 32px;
        margin-bottom: 2px;
        background-color: transparent;
        background-image: url(../../../.icons/menu.gif);
        background-repeat: repeat-x;
        background-position: left top;
        border-bottom-width: 1px;
        border-bottom-style: solid;
        border-bottom-color: #ded0a5;
        font-variant: small-caps;
        font-weight: bold;
        color: black;
      }
      .block .content {
        padding: 10px 20px 0px 20px;
        margin-bottom: 20px;
      }
      .block .content > p {
        margin-bottom: 10px;
      }
      .block .content > p {
        background: url(../../../.icons/tick.gif) -5px -5px no-repeat;
        padding-left: 30px;
      }
      pre {
        background-image: url(../../../.icons/header.gif);
        background-repeat: repeat-x;
        background-position: left top;
        background-color: #F8F5EC;
        border-width: 1px;
        border-style: solid;
        border-color: #A9A9A9;
      }
      pre img[src~=\"/icons/blank.gif\"] {
        height: 24px;
        width: 25px;
      }
      pre a[href^=\"?\"] {
        color: white;
      }
      pre hr {
        visibility: hidden;
      }
</style>

 <body onload=\"loaded();\">
    <div id=\"container\">
      <div id=\"title\">
        <h2><span>Salix<br/>The Bonsai OS</span></h2>
      </div>
      <div id=\"head\">
        <div class=\"block\">
          <div class=\"title\">$TITLE</div>
          <div class=\"content\">
            <p><a href=\"http://salixos.org/\" target=\"_blank\">Salix</a> is a linux distribution based on Slackware that is simple and easy to use. Salix aims to be completely backwards compatible with Slackware, so Slackware users can benefit from Salix repositories.</p>
            <p><a href=\"#\" target=\"_blank\">$ARCH2</a></p>
        </div>
    </div>
</div>
<div id=\"body\">

<table>
<tr><td><b>Name</b></td><td><b>Build Script</b></td><td><b>Source Directory</b></td></tr>
" > $HTML

ls -d */* | sed -e s@^@$REPO@g | sort -f -t / -k 8 | \
while IFS=/ read prot z rep arch rel src cat pkg
    do
        printf "<tr><td>%s</td><td><a href=\"%s//%s/%s/%s/%s/%s/%s/SLKBUILD\">SLKBUILD</a></td><td><a href=\"%s//%s/%s/%s/%s/%s/%s/\">source</a></td></tr>\n" \
$pkg $prot $rep $arch $rel $src $cat $pkg $prot $rep $arch $rel $src $cat $pkg
    done >> $HTML

echo "
</table>
</body>
</html>" >> $HTML
