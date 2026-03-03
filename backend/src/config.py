from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    ENV: str = "development"
    MONGODB_URL: str = "mongodb://localhost:27017"
    MONGODB_DB: str = "borning_challenge"
    CORS_ORIGINS: list[str] = ["*"]

    @property
    def is_production(self) -> bool:
        return self.ENV == "production"


settings = Settings()
