mkdir ../addons 2> /dev/null

if [ ! -d "$../addons/richtext2" ]; then
	unzip -q GodotRichTextLabel2.zip
	mv addons/richtext2 ../addons/
	rm addons/ -r
fi
