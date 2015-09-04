# gameoflife
Conway's Game of Life

## Run unit tests

	$ rake test

## Run game
In the console:

	$ rake console

In web browser with default port 8080:

	$ rake web

In web browser with custom port:

	$ rake web PORT=9000

## Requirements

* Ruby >= 1.9.3
* Rake >= 0.9.2.2
* Linux/Mac VT100-compatible tty console or HTTP/1.1 browser

## Notes

* Assuming browser will direct all ajax calls over the same connection
