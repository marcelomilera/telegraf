FROM golang:1.16 as BUILD

RUN git clone --depth 1 -b feature-add-github-workflow-event https://github.com/marcelomilera/telegraf.git /go/src/github.com/influxdata/telegraf
WORKDIR /go/src/github.com/influxdata/telegraf
RUN make

FROM telegraf:1.16
COPY --from=BUILD /go/src/github.com/influxdata/telegraf/telegraf /usr/bin/telegraf
ENTRYPOINT [ "/usr/bin/telegraf" ]
CMD ["--config","/etc/telegraf/telegraf.conf"]
