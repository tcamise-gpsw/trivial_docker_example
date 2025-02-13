from pathlib import Path
import argparse
import json
from pydantic import BaseModel


class Person(BaseModel):
    first_name: str
    last_name: str


class People(BaseModel):
    people: list[Person]


def main(args: argparse.Namespace):
    print(f"operating on ${args.json_file}")
    for person in People(**json.loads(args.json_file.read_text())).people:
        print(f"{person.last_name}, {person.first_name}")


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Accept text input and feed it to the cow")
    parser.add_argument(
        "json_file",
        type=Path,
        help="path to json file to parse",
    )

    return parser.parse_args()


def entrypoint() -> None:
    main(parse_arguments())


if __name__ == "__main__":
    entrypoint()
