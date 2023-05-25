"""Main app baise route"""
from fastapi import FastAPI
from schemas.user import UserIn, UserOut
from config.db_config import Base, engine, SessionLocal

Base.metadata.create_all(bind=engine)

app = FastAPI()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/", tags=["root"])
async def read_root() -> dict:
    """print data"""
    return {"message": "fast signal"}


@app.post("/add-user", response_model=UserOut, status_code=201, tags=["Add User"])
async def create_user(user: UserIn):
    return user

