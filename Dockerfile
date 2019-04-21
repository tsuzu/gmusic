FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y python3-dev \
    wget \
	ffmpeg && \
    cd /tmp && \
	wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py && \
	apt remove -y wget && \
	pip install -U google-music-scripts && \
	pip install eyeD3
WORKDIR /root

CMD /bin/bash
