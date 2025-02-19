from pydantic import BaseModel


class Person(BaseModel):
    first_name: str
    last_name: str


class People(BaseModel):
    people: list[Person]
