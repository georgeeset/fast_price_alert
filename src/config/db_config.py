"""Configure Mysql database"""
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import os


MYSQL_PWD = os.environ.get('MYSQL_PWD')
MYSQL_USER = os.environ.get('MYSQL_USER')
MYSQL_HOST = os.environ.get('MYSQL_HOST')
MYSQL_DB = os.environ.get('MYSQL_DB')


# print(f'{MYSQL_USER}, {MYSQL_PWD}, {MYSQL_HOST}, {MYSQL_DB}')

# engine = create_engine('mysql+pymysql://{}:{}@{}/{}'.
#                               format(MYSQL_USER,
#                                      MYSQL_PWD,
#                                      MYSQL_HOST,
#                                      MYSQL_DB
#                                      ), echo=True)

engine = create_engine('mysql+mysqldb://{}:{}@{}/{}'.
                              format(MYSQL_USER,
                                     MYSQL_PWD,
                                     MYSQL_HOST,
                                     MYSQL_DB
                                     ), echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()