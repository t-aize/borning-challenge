.PHONY: install clean run build test lint format format-check

install:
	flutter pub get

clean:
	flutter clean
	flutter pub get

run:
	flutter run -d web-server --web-port=8080

build:
	flutter build web --release

test:
	flutter test

lint:
	flutter analyze

format:
	dart format lib/ test/

format-check:
	dart format --set-exit-if-changed lib/ test/
