#!/bin/sh
go build
./staw -in ../sites/garbe.ca -out /var/www/garbe.ca -t 'Anselm R. Garbe' -css style.css
./staw -in ../sites/sta.li -out /var/www/sta.li -t 'static linux' -css style.css
./staw -in ../sites/beec.ca -out /var/www/beec.ca -t 'Anselms bee research &amp; apiary' -css style.css
