FROM debian:stable

RUN apt update && apt install -y wget curl gcc g++ xz-utils git python3 cmake
RUN wget -qO - https://nim-lang.org/choosenim/init.sh > setup_nim.sh && sh setup_nim.sh -y
RUN mkdir -p /home/nmusd/base/deps/
RUN mkdir -p /home/nmusd/base/templates/
RUN mkdir -p /home/nmusd/base/src/

COPY templates/ /home/nmusd/base/templates/
COPY data/ /home/nmusd/base/
COPY build_all.sh /home/nmusd/base/
COPY run.sh /home/nmusd/base/

ENV PATH="~/.nimble/bin/:${PATH}"

RUN cd /home/nmusd/base && ./build_all.sh

WORKDIR "/home/nmusd/base/"
