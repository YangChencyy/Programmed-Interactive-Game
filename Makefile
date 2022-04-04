all: main

main:
	elm make src/Main.elm --output elm.js
	elm make src/Main.elm
	mkdir build
	cp index.html build/index.html
	cp elm.js build/elm.js
	cp -r --remove-destination picture/ build/picture
	cp -r --remove-destination audio/ build/audio
	cp -r --remove-destination doc/ build/doc