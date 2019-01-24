FROM fluent/fluentd

RUN apk add curl-dev wget build-base ruby-dev \
	&& gem install fluent-plugin-kubernetes_metadata_filter \
                fluent-plugin-forest \
                gelf\
	&&  mkdir -p /etc/fluent/plugin \
    && wget https://raw.githubusercontent.com/tech-angels/fluent-plugin-gelf/master/lib/fluent/plugin/out_gelf.rb -O /etc/fluent/plugin/out_gelf.rb \

    && apk del build-base ruby-dev

ENV GELF_HOST graylog.default.svc.cluster.local
ENV GELF_PORT 12900

ADD fluent.conf /etc/fluent/fluent.conf

ENTRYPOINT ["fluentd"]
