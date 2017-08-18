FROM ubuntu:14.04

RUN apt-get update -qqy && \
    apt-get install -qqy build-essential libboost-dev libboost-program-options-dev wget vim

RUN wget --quiet http://homepages.dcc.ufmg.br/~lcerf/prototypes/d-peeler-2.12.tar.bz2 && \
	tar jxf d-peeler-2.12.tar.bz2 && cd d-peeler && make install && mkdir d-peeler-workdir

WORKDIR /d-peeler-workdir

COPY entrypoint.sh /entrypoint.sh
COPY datapeeler.sh /datapeeler.sh
ENTRYPOINT ["/entrypoint.sh"]
