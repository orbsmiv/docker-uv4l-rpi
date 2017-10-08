FROM resin/raspberrypi3-debian:jessie

MAINTAINER orbsmiv@hotmail.com

RUN [ "cross-build-start" ]

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
        curl

RUN curl http://www.linux-projects.org/listing/uv4l_repo/lrkey.asc | apt-key add -

RUN echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ jessie main" >> /etc/apt/sources.list

RUN apt-get update && \
        apt-get install -y --no-install-recommends \
        uv4l \
        uv4l-raspicam-extras \
        uv4l-tc358743-extras \
        uv4l-server \
        uv4l-uvc \
        uv4l-xscreen \
        uv4l-mjpegstream \
        uv4l-dummy \
        uv4l-raspidisp \
        uv4l-webrtc \
        uv4l-demos \
        uv4l-raspicam && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Final settings
# COPY uv4l-raspicam.conf /etc/uv4l/uv4l-raspicam.conf

ENTRYPOINT ["/usr/bin/uv4l"]

CMD ["--driver raspicam", "--driver-config-file=/etc/uv4l/uv4l-raspicam.conf"]


RUN [ "cross-build-end" ]
