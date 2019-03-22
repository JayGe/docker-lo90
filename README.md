# docker-lo90
Lo-90 / LilacSat 1 in docker

## About

This docker container will run the lilacsat proxy, along with the gnuradio RTL frontend and the demodulator.

It works in my version of Ubuntu with pulseaudio sound fine, not made any effort to make the image smaller or to work with anything else yet

## Building 

docker build . -t gi7ugv/docker-lo90

## Usage

You firstly might have to run the following to allow the X11 connection:

xhost local:root

Start the container with the following: 

docker run --rm -it -e DISPLAY --net=host --pid=host --ipc=host -v /dev/bus/usb:/dev/bus/usb --privileged -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native -v ~/.config/pulse/cookie:/root/.config/pulse/cookie gi7ugv/docker-lo90

It will start with the LilacSat-1 proxy program, enter your callsign and location parameters, click update orbit and wait for the message in the text box below, then click "Start Proxy", then "Start GNU Radio". 

At this point everything should work as normal, run frontend_lilacsat1_rx_rtl which should hopefully start the RTL receiver, then run demod_lilacsat_1 and you should see things working and Receiver A connected in the proxy program 
