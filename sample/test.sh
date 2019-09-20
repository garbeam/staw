#!/bin/sh
./generate.sh
go build
open http://localhost:8080/
echo Click reload in your browser 
./sample -p 8080 -d out/example.com
