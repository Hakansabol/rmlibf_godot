#!/bin/bash

# lazy check if this is the right directory, this does have the caveat of working in subdirectories but like don't do that :\
if [ ! $(pwd | grep rmlibf) ]; then
	echo -e "\e[31merror: \e[0mplease run from the rmlibf_godot directory."
	exit 1
fi

mkdir ../scripts ../sprites ../sounds ../scenes ../addons 

if [ ! -d "../addons/richtext2" ]; then
	unzip -q GodotRichTextLabel2.zip
	mv addons/richtext2 ../addons/
	rm addons/ -r
fi

# link all the folders into the root dir
# ln -sdrT scripts ../scripts/rml
# ln -sdrT sprites ../sprites/rml
# ln -sdrT shaders ../sprites/shaders
# ln -sdrT sounds ../sounds/rml
# ln -sdrT prefabs ../scenes/rml

echo -e "\e[32mreminder: \e[0mRegister scripts/game_manager.gd as an autoload under the name GameManager (likely default) to fix errors!"
