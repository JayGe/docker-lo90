FROM ubuntu:18.04

# prevent tzdata asking questions

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y gnuradio gnuradio-dev build-essential

RUN apt-get install -y git cmake swig wget gr-osmosdr python-qt4 python-dbus pulseaudio xterm

RUN mkdir -p /app/lilacsat

WORKDIR /app/lilacsat

RUN git clone https://github.com/JayGe/gr-lilacsat.git; cd gr-lilacsat/cmake; cmake -DCMAKE_INSTALL_PREFIX=/usr ../ ; make install

RUN wget https://files.pythonhosted.org/packages/e5/c6/3e3aeef38bb0c27364af3d21493d9690c7c3925f298559bca3c48b7c9419/construct-2.8.22.tar.gz; tar -zxvf construct-2.8.22.tar.gz; cd construct-2.8.22; python setup.py install

RUN git clone https://github.com/daniestevez/gr-csp.git; cd gr-csp/cmake; cmake -DCMAKE_INSTALL_PREFIX=/usr ../; make; make install

RUN /bin/bash gr-lilacsat/examples/LilacSat-1/proxy_publish/setup.sh

RUN sed -i "s/xterm_executable =.*/xterm_executable = \/usr\/bin\/xterm/" /etc/gnuradio/conf.d/grc.conf

#RUN apt-get install -y firefox pulseaudio-utils
#RUN apt-get install -y pavucontrol alsa-base alsa-utils 

CMD gr-lilacsat/examples/LilacSat-1/proxy_publish/lilacsat_proxy.py
