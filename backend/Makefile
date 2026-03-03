.PHONY: dev start lint format test

dev:
	uv run uvicorn src.main:app --reload --port 8000

start:
	uv run uvicorn src.main:app --port 8000

lint:
	uv run ruff check src

lint-fix:
	uv run ruff check --fix src

format:
	uv run ruff format src

test:
	uv run pytest

