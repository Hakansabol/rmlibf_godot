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

# Spawn other files.
mkdir ../sprites 2> /dev/null
mkdir ../scenes 2> /dev/null
mkdir ../sounds 2> /dev/null
mkdir ../scripts 2> /dev/null
cp ./.scripts/game_manager ../scripts/game_manager.gd --no-clobber
cp ./.scripts/camera2D ../scripts/camera2D.gd --no-clobber
cp ./.scripts/dialogue ../scripts/dialogue.gd --no-clobber
cp ./.scripts/entity ../scripts/entity.gd --no-clobber
cp ./.scripts/player ../scripts/player.gd --no-clobber
cp ./.scripts/projectile ../scripts/projectile.gd --no-clobber
cp ./.scripts/proj_linear ../scripts/proj_linear.gd --no-clobber

echo -e "\e[32mreminder: \e[0mRegister scripts/game_manager.gd as an autoload under the name GameManager (likely default) to fix errors!"
