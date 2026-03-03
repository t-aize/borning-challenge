from datetime import date

from ..models.activity import Activity

USERS_DATA: dict[str, list[Activity]] = {
    "user_1": [
        Activity(
            id="a1",
            type="running",
            date=date(2026, 2, 1),
            duration=45,
            distance=8.5,
            elevation=120,
        ),
        Activity(
            id="a2",
            type="cycling",
            date=date(2026, 2, 5),
            duration=90,
            distance=35.0,
            elevation=450,
        ),
        Activity(
            id="a3",
            type="swimming",
            date=date(2026, 2, 10),
            duration=60,
            distance=2.0,
            elevation=0,
        ),
    ],
    "user_2": [
        Activity(
            id="a4",
            type="running",
            date=date(2026, 2, 3),
            duration=30,
            distance=5.0,
            elevation=80,
        ),
        Activity(
            id="a5",
            type="cycling",
            date=date(2026, 2, 8),
            duration=120,
            distance=50.0,
            elevation=600,
        ),
    ],
    "user_3": [
        Activity(
            id="a6",
            type="running",
            date=date(2026, 2, 2),
            duration=55,
            distance=10.0,
            elevation=150,
        ),
        Activity(
            id="a7",
            type="racket",
            date=date(2026, 2, 7),
            duration=60,
            distance=3.0,
            elevation=0,
        ),
        Activity(
            id="a8",
            type="cycling",
            date=date(2026, 2, 12),
            duration=75,
            distance=28.0,
            elevation=320,
        ),
    ],
    "user_4": [
        Activity(
            id="a9",
            type="swimming",
            date=date(2026, 2, 4),
            duration=40,
            distance=1.5,
            elevation=0,
        ),
        Activity(
            id="a10",
            type="running",
            date=date(2026, 2, 9),
            duration=60,
            distance=12.0,
            elevation=200,
        ),
    ],
    "user_5": [
        Activity(
            id="a11",
            type="cycling",
            date=date(2026, 2, 6),
            duration=110,
            distance=45.0,
            elevation=520,
        ),
        Activity(
            id="a12",
            type="strength",
            date=date(2026, 2, 11),
            duration=50,
            distance=0.0,
            elevation=0,
        ),
        Activity(
            id="a13",
            type="running",
            date=date(2026, 2, 13),
            duration=35,
            distance=6.5,
            elevation=90,
        ),
    ],
    "user_6": [
        Activity(
            id="a14",
            type="running",
            date=date(2026, 2, 1),
            duration=40,
            distance=7.0,
            elevation=100,
        ),
        Activity(
            id="a15",
            type="swimming",
            date=date(2026, 2, 5),
            duration=45,
            distance=1.8,
            elevation=0,
        ),
        Activity(
            id="a16",
            type="cycling",
            date=date(2026, 2, 9),
            duration=100,
            distance=40.0,
            elevation=480,
        ),
        Activity(
            id="a17",
            type="racket",
            date=date(2026, 2, 14),
            duration=55,
            distance=2.5,
            elevation=0,
        ),
    ],
}

TEAMS_DATA: dict[str, list[str]] = {
    "team_1": ["user_1", "user_2", "user_3", "user_4", "user_5", "user_6"],
}
