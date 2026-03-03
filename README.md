# 🏃 Borning Challenge

> Web platform for Alstom's internal multisport challenge — internship project at Alstom Belgium, Charleroi.

## Context

**Borning Challenge** is an internal Alstom program designed to promote well-being and team cohesion through a 13-week
multisport competition. Open to beginners and seasoned athletes alike, the challenge focuses on activity volume rather
than performance.

Participants are organized into teams of 6 and accumulate kilometers across various sport categories (cycling, swimming,
running, strength training, racket sports, etc.), completing individual and collective challenges tracked via weekly and
global leaderboards — with an expected participation of ~350 employees.

This repository contains the technical proposal developed as part of an internship application, which will eventually be
integrated into the main Borning Challenge platform.

## Features

- 👤 **User activity page** — view personal sport activities with stats summary
- 👥 **Team activity page** — view aggregated team stats across all 6 members
- 📊 **Statistics dashboard** — total distance, elevation gain, duration, activity count
- 📈 **Charts** — graphical visualization of activity data
- 🔗 **REST API** — FastAPI backend exposing endpoints for user and team activities

## Tech Stack

| Layer    | Technology                                                                   |
|----------|------------------------------------------------------------------------------|
| Backend  | [Python](https://www.python.org/) + [FastAPI](https://fastapi.tiangolo.com/) |
| Frontend | [Flutter](https://flutter.dev/) (SPA, Material Design)                       |
| Database | [MongoDB](https://www.mongodb.com/)                                          |

> Note: Sample data is hardcoded for this demo proposal.

## Project Structure

```
borning-challenge/
├── backend/              # FastAPI application
│   ├── main.py           # Entry point & route definitions
│   ├── models/           # Data models (Pydantic)
│   ├── data/             # Hardcoded sample data
│   └── requirements.txt
├── frontend/             # Flutter application
│   ├── lib/
│   │   ├── main.dart     # App entry point
│   │   ├── pages/        # User & Team activity pages
│   │   ├── widgets/      # Reusable UI components
│   │   └── services/     # API service layer
│   └── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites

- Python `3.11+`
- Flutter `3.x`
- Dart `3.x`

### Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

API will be available at `http://localhost:8000`.  
Interactive docs: `http://localhost:8000/docs`

#### Endpoints

| Method | Route                        | Description                         |
|--------|------------------------------|-------------------------------------|
| `GET`  | `/activities/user/{user_id}` | Get all activities for a given user |
| `GET`  | `/activities/team/{team_id}` | Get all activities for a given team |

### Frontend

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

App will be available at `http://localhost:PORT`.

## Demo

A short demo video is available — presented during the internship interview to showcase the platform's functionality and
UX.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
