#!/bin/sh
go build
mkdir -p /tmp/www
./staw -in sites/example.com -out /tmp/www/example.com -p file:///tmp/www/example.com -t 'An example' -css style.css
./staw -in sites/other.example.com -out /tmp/www/other.example.com -p file:///tmp/www/other.example.com -t 'Another example' -css style.css
open file:///tmp/www/example.com/index.html
