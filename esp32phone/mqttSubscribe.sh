#!/bin/bash

if [ $# -eq 0 ] ; then
	echo "Error params: specify baresip command in format: \"esp32phone_[MAC]\" cmd arg1 arg2"
	exit 1
fi

devicename=$1
shift

topic="#"

x=$(mosquitto_pub --help | grep "help" | tail -n 1)
if [[ "x$x" == "x" ]] ; then
	echo "Install mosquitto-clients first."
	echo "apt-get install mosquitto-clients"
	exit 1	
fi

mqttserver=cspiel.at
mqttpass=jackson_oida
mqttport=1883
mqttuser=esp32phone


mosquitto_sub -h $mqttserver -p $mqttport -t "$devicename/$topic"  -q 2 -i MyPcClient -u "esp32phone" -P "$mqttpass" -v
