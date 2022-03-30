FROM debian:11.3 AS build

LABEL maintainer="koyashiro <develop@koyashi.ro>"

ENV NGINX_VERSION=1.21.6
ENV NGINX_RTMP_MODULE_VERSION=1.2.2
ENV BUILDDIR=/tmp/build

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    build-essential \
    ca-certificates \
    curl \
    libpcre3-dev \
    libssl-dev \
    libz-dev

WORKDIR ${BUILDDIR}
RUN curl -O "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" \
  && tar xvzf nginx-${NGINX_VERSION}.tar.gz
RUN curl -LO "https://github.com/arut/nginx-rtmp-module/archive/refs/tags/v${NGINX_RTMP_MODULE_VERSION}.tar.gz" \
  && tar xvzf v${NGINX_RTMP_MODULE_VERSION}.tar.gz

WORKDIR ${BUILDDIR}/nginx-${NGINX_VERSION}
RUN ./configure \
    --sbin-path=/usr/local/sbin/nginx \
    --modules-path=/usr/local/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --pid-path=/var/run/nginx/nginx.pid \
    --with-threads \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-ipv6 \
    --with-stream \
    --with-stream_ssl_module \
    --add-module="${BUILDDIR}/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}" \
  && make \
  && make install
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stdout /var/log/nginx/error.log

FROM debian:11.3-slim

COPY --from=build /usr/local/sbin/nginx /usr/local/sbin/nginx
COPY --from=build /etc/nginx /etc/nginx
COPY --from=build /usr/local/nginx/html /usr/local/nginx/html
COPY --from=build /var/run/nginx /var/run/nginx
COPY --from=build /var/log/nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
