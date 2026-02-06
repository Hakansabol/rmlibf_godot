mkdir ../addons 2> /dev/null

if [ ! -d "../addons/richtext2" ]; then
	unzip -q GodotRichTextLabel2.zip
	mv addons/richtext2 ../addons/
	rm addons/ -r
fi

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
