FROM alpine:3.7

RUN mkdir -p dump

ADD ./*.sql /dump/