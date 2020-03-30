FROM mtsl-base:latest

RUN apt install -y swi-prolog swi-prolog-doc
COPY test.pl /
COPY tryit.sh /
RUN /tryit.sh
