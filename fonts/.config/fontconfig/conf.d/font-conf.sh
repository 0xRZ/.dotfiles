#!/usr/bin/env bash

# might help if fonts are ugly
# to check currently sourced settings of FreeType font rendering library for e.g. alacritty use 
# FC_DEBUG=1 alacritty
# man fonts-conf
ln -fs /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf
ln -fs /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf
ln -fs /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf
ln -fs /usr/share/fontconfig/conf.avail/10-hinting-slight.conf
