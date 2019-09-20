#!/bin/sh
cd ..
go build
cd sample
rm -rf out
mkdir -p out
../staw -in sites/example.com -out out/example.com -t 'An example'
cp -f style.css out/example.com
../staw -in sites/other.example.com -out out/other.example.com -t 'Another example'
cp -f style.css out/other.example.com
