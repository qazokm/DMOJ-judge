FROM debian:buster

RUN groupadd -r judge && useradd -r -g judge judge
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends python2.7-dev wget file ca-certificates
RUN apt-get install -y --no-install-recommends g++
RUN apt-get install -y --no-install-recommends g++-7
RUN apt-get install -y --no-install-recommends gcc
RUN apt-get install -y --no-install-recommends ghc
RUN apt-get install -y --no-install-recommends openjdk-8-jdk-headless openjdk-8-jre-headless ca-certificates-java
RUN apt-get install -y --no-install-recommends python
RUN apt-get install -y --no-install-recommends python3
RUN apt-get clean


RUN wget -q -O- https://bootstrap.pypa.io/get-pip.py | python && \
    pip install --no-cache-dir pyyaml watchdog cython ansi2html termcolor && \
    rm -rf ~/.cache

RUN mkdir /problems

COPY . /judge
WORKDIR /judge

RUN env DMOJ_REDIST=1 python setup.py develop && rm -rf build/

COPY judge.yml /judge/
USER judge

ENTRYPOINT ["/judge/docker-entry"]
