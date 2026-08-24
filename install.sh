#!/bin/bash

# lazy check if this is the right directory, this does have the caveat of working in subdirectories but like don't do that :\
if [ ! $(pwd | grep rmlibf) ]; then
	echo -e "\e[31merror: \e[0mplease run from the rmlibf_godot directory."
	exit 1
fi

# create the destination folder for unzip.
mkdir ../addons 2> /dev/null

if [ ! -d "../addons/richtext2" ]; then
	unzip -q GodotRichTextLabel2.zip
	mv addons/richtext2 ../addons/
	rm addons/ -r
fi

echo -e "\e[32mreminder: \e[0mRegister scripts/game_manager.gd as an autoload under the name GameManager (likely default) to fix errors!"

# these folders are created conditionally rather than supressing the error stream, I don't remember why.
if [ ! -d "../sprites" ]; then
	mkdir ../sprites
fi
if [ ! -d "../scenes" ]; then
	mkdir ../scenes
fi
if [ ! -d "../sounds" ]; then
	mkdir ../sounds
fi
if [ ! -d "../scripts" ]; then
	mkdir ../scripts
fi

# Spawn other files.
# This is a template, meaning it is meant to be edited for this individual project, unlike most other scripts, which are meant to be extended and left unchanged.
cp ./extras/game_manager ../scripts/game_manager.gd --no-clobber
