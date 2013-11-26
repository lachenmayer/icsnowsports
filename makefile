.PHONY: build clean clean_deps

all: build

node_modules:
	npm install

bin:
	mkdir bin bin/js bin/css bin/img

js/%.coffee: bin node_modules
	./node_modules/.bin/coffee -co bin/js $@

css/style.styl: bin node_modules
	./node_modules/.bin/stylus -o bin/css -c css/style.styl

%.jade: bin node_modules
	./node_modules/.bin/jade -o bin/ $@

img/%: bin
	cp $@ bin/img/

clean:
	rm -rf bin/

clean_deps:
	rm -rf node_modules/

build: js/* css/* img/* index.jade

sync: build
	scp -r bin/* hl2711@dougal.union.ic.ac.uk:/website/acc/ski