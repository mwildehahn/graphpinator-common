.PHONY: build test hh_autoload format

build:
	docker build -t mwildehahn/graphpinator-common .

hh_autoload:
	docker run -it mwildehahn/graphpinator-common ./vendor/bin/hh-autoload

test: hh_autoload
	docker run -it mwildehahn/graphpinator-common ./vendor/bin/hacktest tests

format:
	docker run -it mwildehahn/graphpinator-common find {src,tests} -type f -exec hackfmt -i {} \;