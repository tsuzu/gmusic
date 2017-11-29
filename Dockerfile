FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3-dev \
      wget \
      xz-utils \
	  git
WORKDIR /tmp

RUN wget http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz \
      && tar Jxvf ./ffmpeg-release-64bit-static.tar.xz \
      && cp ./ffmpeg*64bit-static/ffmpeg /usr/local/bin/

RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && rm get-pip.py
RUN git clone https://github.com/thebigmunch/gmusicapi-wrapper.git

RUN apt-get install -y gcc
RUN cd gmusicapi-wrapper && python3 setup.py install
RUN wget https://raw.githubusercontent.com/thebigmunch/gmusicapi-scripts/master/gmusicapi_scripts/gmupload.py && mv gmupload.py /usr/bin/gmupload && chmod +x /usr/bin/gmupload
RUN pip install docopt
RUN echo "gmupload --uploader-id=2E:86:E6:63:09:2B" > /root/init.sh && chmod +x /root/init.sh
RUN echo 'alias gmupload="gmupload --uploader-id=2E:86:E6:63:09:2B"' >> ~/.bashrc
RUN pip install eyeD3
WORKDIR /root

CMD /bin/bash
