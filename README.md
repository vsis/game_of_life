# Game of Life

This is my implementation of Conway's Game of Life.
It's part of my process of learning Ruby

## How to execute it

To generate a random universe and start the game, run: `./play.sh`.
You may use these keys to manipulate the game:

 - `spacebar` to run/pause the game
 - `n` when paused, go to next generation
 - `q` quit

Also you can start a map. This repo comes with some examples in `example_maps` directory.
For example: `./play.sh example_maps/01.map`

## Unit tests

This project doesn't have too much test coverage, but you can run all existing unit tests with: `ruby tests/unit/ts_all.rb`

## TODO
 - [ ] gemfile
 - [ ] dockerfile
 - [ ] human-readable error messages

