# 🏃 Borning Challenge

> Web platform for Alstom's internal multisport challenge — internship project at Alstom Belgium, Charleroi.

## Context

**Borning Challenge** is an internal Alstom program designed to promote well-being and team cohesion through a 13-week
multisport competition. Open to beginners and seasoned athletes alike, the challenge focuses on activity volume rather
than performance.

Participants, organized into **teams of 6**, accumulate kilometers across various sport categories (cycling, swimming,
running, strength training, racket sports…), with an expected participation of around 350 employees.

This repository contains the technical proposal developed as part of an internship application, intended to be
integrated into the main project.

## Features

- 👤 **User activities page** — view personal sport activities with statistics
- 👥 **Team activities page** — aggregated statistics across all 6 team members
- 📊 **Dashboard** — total distance, cumulative elevation, total duration, activity count
- 📈 **Charts** — bar chart (distance by type) + pie chart (time distribution)
- 🔗 **REST API** — FastAPI backend with dynamic endpoints for users and teams
- 🎨 **Responsive design** — Material Design 3, adaptive for mobile / tablet / desktop

## Tech Stack

| Layer    | Technology                                                                                                                                                             |
|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Backend  | [Python 3.13](https://www.python.org/) + [FastAPI](https://fastapi.tiangolo.com/)                                                                                      |
| Frontend | [Flutter](https://flutter.dev/) (SPA, Material Design 3)                                                                                                               |
| Database | [MongoDB](https://www.mongodb.com/) (via [Motor](https://motor.readthedocs.io/))                                                                                       |
| Tooling  | [uv](https://docs.astral.sh/uv/), [Ruff](https://docs.astral.sh/ruff/), [Pyright](https://github.com/microsoft/pyright), [fl_chart](https://pub.dev/packages/fl_chart) |

## Project Structure

```
borning-challenge/
├── backend/
│   ├── src/
│   │   ├── data/          # Hardcoded seed data
│   │   ├── models/        # Pydantic models (Activity, Team)
│   │   ├── routers/       # FastAPI routes (users, teams)
│   │   ├── services/      # Business logic + compute_stats
│   │   ├── config.py      # Configuration (env, CORS, MongoDB)
│   │   ├── database.py    # MongoDB connection (Database class)
│   │   └── main.py        # FastAPI entrypoint
│   ├── tests/             # Async pytest tests
│   ├── scripts/           # MongoDB seed script
│   ├── pyproject.toml
│   └── Makefile
├── frontend/
│   ├── lib/
│   │   ├── models/        # Dart models (Activity, ActivityStats, TeamStats)
│   │   ├── pages/         # Pages (user, team)
│   │   ├── services/      # API service (http)
│   │   ├── utils/         # Shared helpers (colors, icons, formatting)
│   │   ├── widgets/       # Reusable widgets (StatsCards, Charts, ActivityList, AsyncContent)
│   │   └── main.dart      # Flutter entrypoint
│   ├── test/              # Flutter widget tests
│   ├── pubspec.yaml
│   └── Makefile
└── README.md
```

## API Endpoints

| Method | Route                         | Description                          |
|--------|-------------------------------|--------------------------------------|
| `GET`  | `/users`                      | List all user IDs                    |
| `GET`  | `/users/{user_id}/activities` | Activities and statistics for a user |
| `GET`  | `/teams`                      | List all team IDs                    |
| `GET`  | `/teams/{team_id}/activities` | Activities and statistics for a team |

## Prerequisites

- **Python** ≥ 3.13
- **uv** ([install](https://docs.astral.sh/uv/getting-started/installation/))
- **Flutter** ≥ 3.11 ([install](https://docs.flutter.dev/get-started/install))
- **MongoDB** (optional, production mode only)

## Tests

| Part     | Command     | Tests                                                            |
|----------|-------------|------------------------------------------------------------------|
| Backend  | `make test` | 13 tests (async pytest) — routes, stats, sorting, 404, listing   |
| Frontend | `make test` | 49 tests (widget tests) — helpers, models, widgets, async states |

## Development vs Production

|              | Development                 | Production                |
|--------------|-----------------------------|---------------------------|
| **Data**     | Hardcoded in `seed.py`      | MongoDB                   |
| **API Docs** | `/docs` (Swagger)           | Disabled                  |
| **Config**   | `ENV=development` (default) | `ENV=production` + `.env` |

For production mode, create a `.env` file in `backend/`:

```env
ENV=production
MONGODB_URL=mongodb://localhost:27017
MONGODB_DB=borning_challenge
```

Then seed the database:

```bash
make seed
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
