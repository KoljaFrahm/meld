FROM ubuntu:resolute

# SET ENV VARS
ENV RES=1920x1080 \
    DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0

# INSTALL DEPS
RUN apt-get update && apt-get -y install \
    curl \
    meld \
    xvfb \
    x11vnc \
    supervisor \
    i3 \
    novnc \
    && rm -rf /etc/i3/config;

# COPY I3 CONFIG
COPY i3config /etc/i3/config

# ADD SUPERVISOR CONFIG
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# RUN UNDERPRIVILEGED
RUN useradd -m user
USER user
WORKDIR /home/user

# EXPOSE PORT
EXPOSE 8080

# START SUPERVISORD
CMD ["/usr/bin/supervisord"]
