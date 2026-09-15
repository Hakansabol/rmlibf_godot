if [ -d "$1/.godot" ]; then 
	# copy all the folders FROM the root dir
	cp -rT $1/scripts/rml scripts
	cp -rT $1/sprites/rml sprites 
	cp -rT $1/sprites/shaders shaders 
	cp -rT $1/sounds/rml sounds 
	cp -rT $1/scenes/rml prefabs 
else
	echo -e "\e[32mFailed to pull assets: specify a directory containing a .godot folder!"
fi
