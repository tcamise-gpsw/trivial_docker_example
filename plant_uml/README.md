# Plant UML CLI Docker Image

This is a wrapper around the [plant UML jar](https://plantuml.com/starting) to define a Docker image to build a
one-off Plant UML diagram.

## Usage

Use the helper script as such:

```cmd
./dockerized_plant_uml.sh $UML
```

where $UML is the UML definition to convert, for example: `dockerized_plant_uml.sh test.puml`

The output will be placed in the `shared_volume` directory.

## TODO

We probably don't need to build from full Ubuntu and could use a smaller Java-based image.
