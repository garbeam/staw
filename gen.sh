#!/bin/sh
go build
./staw -in ../sites/garbe.ca -out /var/www/static/garbe.ca -t 'Anselm R. Garbe' -css style.css
./staw -in ../sites/sta.li -out /var/www/static/sta.li -t 'static linux' -css style.css
./staw -in ../sites/beec.ca -out /var/www/static/beec.ca -t 'Anselm&#39;s bee research &amp; apiary' -css style.css
