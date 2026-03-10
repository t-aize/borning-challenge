.PHONY: dev start install clean run build test lint lint-fix format format-check type-check

dev:
	flutter run -d chrome --web-port=8080

start:
	flutter run -d web-server --web-port=8080

install:
	flutter pub get

clean:
	flutter clean
	flutter pub get

build:
	flutter build web --release

test:
	flutter test

lint:
	flutter analyze

lint-fix:
	dart fix --apply

format:
	dart format lib/ test/

format-check:
	dart format --set-exit-if-changed lib/ test/

type-check:
	flutter analyze
