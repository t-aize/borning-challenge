from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .routers import teams, users

app = FastAPI(title="Borning Challenge API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # restreindre en prod
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(users.router)
app.include_router(teams.router)
