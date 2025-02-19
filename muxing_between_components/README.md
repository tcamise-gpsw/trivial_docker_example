# Trivial Docker Example

A Trivial Docker Example for Tinkering / Demonstration

## Overview

The repo consists of two python packages

-   Python Package A which contains a script `tell-the-cow` to output some cowspeak
-   Python Package B which contains a script `reverse-names` to parse a JSON file of people and print their names reverse

These are accessed via a shared Docker container that contains both of these installed scripts. The scripts are
selected via the arguments passed to `entrypoint.sh` as such:

-   the first word passed is the task (`tell-the-cow` or `reverse-names`)
-   all subsequent words are arguments passed to the first task

There is a helper `Makefile` and `dockerize` script for the end user to hide some of the Docker syntax.

## Setup

perform `make setup` to build the Docker image

## Usage

### Tell the cow

Simply pass your desired text to the cow via:

```
$ ./dockerize tell-the-cow something to say
performing [tell-the-cow] with arguments [something to say]
  ________________
| something to say |
  ================
                \
                 \
                   ^__^
                   (oo)\_______
                   (__)\       )\/\
                       ||----w |
                       ||     ||
```

### Reverse Names

There is a tricky problem to solve here in that we need to pass a file to `reverse-names`. We can't rely on the name
or location of the file to be constant and we'd like to reuse this scheme for future tasks that require files.

This was solved by sharing the (mostly empty) `shared_volume` directory between the host and the container. Therefore,
the user (or any scripts) can temporarily place any input files that are needed by the current task and then pass
the file name / location to the `dockerize` helper. The only difference is that the path needs to start from root
rather than the current directory. That is, you should use `/shared_volume/SUB1/SUB2/file` instead of
`./shared_volume/SUB1/SUB2/file`

In the following example we temporarily copy the `people.json` vector from Python Package B in this way.

```
$ cp ./python_package_b/tests/vectors/people.json ./shared_volume

$ ./dockerize reverse-names /shared_volume/people.json
performing [reverse-names] with arguments [/shared_volume/people.json]
operating on $/shared_volume/people.json
Schmoe, Joe
Doe, Jane
```

> Note that the shared volume can be cleaned at any time via `make clean-shared-volume`

## Extending the Docker image

This was designed to be easily scalable for more Python Packages or any other type of component. The steps are:

1. Update the Dockerfile as needed to use the new component
2. Update the `valid_tasks` argument in `entrypoint.sh` to include the new task.
    1. Ideally this new task would take a `--help` argument to be consistent with the top level Docker container help
    2. TODO To maintain OCP, we could read these `valid_tasks` from a `yml` file instead of directly editing code
    3. Alternatively we don't even need a valid list of tasks and will just throw a user to the error since the task won't be found.
