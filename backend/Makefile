.PHONY: dev start lint lint-fix format test typecheck seed

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

type-check:
	uv run pyright src scripts tests

seed:
	uv run python -m scripts.seed_db
