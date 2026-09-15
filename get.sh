if [ -d "$1/.godot" ]; then 
	# copy all the folders FROM the root dir
	cp -rf $1/scripts/rml scripts
	cp -rf $1/sprites/rml sprites 
	cp -rf $1/sprites/shaders shaders 
	cp -rf $1/sounds/rml sounds 
	cp -rf $1/scenes/rml prefabs 
else
	echo -e "\e[32mFailed to pull assets: specify a directory containing a .godot folder!"
fi
