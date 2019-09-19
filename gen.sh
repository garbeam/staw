#!/bin/sh
go build
mkdir -p /tmp/www
./staw -p file:///tmp/www/garbe.ca -in ../sites/garbe.ca -out /tmp/www/garbe.ca -t 'Anselm R. Garbe' -css style.css
./staw -p file:///tmp/www/sta.li -in ../sites/sta.li -out /tmp/www/sta.li -t 'static linux' -css style.css
./staw -p file:///tmp/www/beec.ca -in ../sites/beec.ca -out /tmp/www/beec.ca -t 'Anselm&#39;s bee research &amp; apiary' -css style.css
