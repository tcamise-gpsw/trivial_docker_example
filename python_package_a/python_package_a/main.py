import argparse
import cowsay


def main(args: argparse.Namespace):
    cowsay.cow(args.text)

def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Accept text input and feed it to the cow")
    parser.add_argument(
        "text",
        type=str,
        help="Text to feed the cow",
    )

    return parser.parse_args()

def entrypoint() -> None:
    main(parse_arguments())

if __name__ == "__main__":
    entrypoint()
