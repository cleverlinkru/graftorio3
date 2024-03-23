FROM ubuntu:22.04

RUN apt update \
    && apt install nginx xz-utils libxext6 libgl1 libxinerama1 libxrandr2 libxcursor1 libasound2 libpulse0 -y

ENTRYPOINT ["entypoint.sh"]
