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

if [ -d "$1/.godot" ]; then 
	# copy all the folders into the root dir
	mkdir $1/scripts $1/sprites $1/sounds $1/scenes
	cp -rn scripts $1/scripts/rml
	cp -rn sprites $1/sprites/rml
	cp -rn shaders $1/sprites/shaders
	cp -rn sounds $1/sounds/rml
	cp -rn prefabs $1/scenes/rml
else
	echo -e "\e[32mFailed to copy assets: specify a directory containing a .godot folder!"
fi

echo -e "\e[32mreminder: \e[0mRegister scripts/game_manager.gd as an autoload under the name GameManager (likely default) to fix errors!"
