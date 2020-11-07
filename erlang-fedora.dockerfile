ARG OS_VERSION

FROM fedora:${OS_VERSION} AS build

ARG ERLANG

RUN dnf -y update
RUN dnf -y install \
  gcc \
  g++ \
  make \
  autoconf \
  ncurses-devel \
  unixODBC-devel \
  $(if [ "${ERLANG:0:1}" = "1" ]; then echo "compat-openssl10"; else echo "openssl-devel"; fi) \
  findutils \
  ca-certificates \
  pax-utils \
  wget

RUN dnf -y clean all && rm -rf /var/cache/yum

RUN mkdir /OTP
RUN wget -nv "https://github.com/erlang/otp/archive/OTP-${ERLANG}.tar.gz" && tar -zxf "OTP-${ERLANG}.tar.gz" -C /OTP --strip-components=1
WORKDIR /OTP
RUN ./otp_build autoconf
RUN ./configure \
  --build="$(dpkg-architecture --query DEB_HOST_GNU_TYPE)" \
  --without-javac \
  --without-wx \
  --without-debugger \
  --without-observer \
  --without-jinterface \
  --without-cosEvent\
  --without-cosEventDomain \
  --without-cosFileTransfer \
  --without-cosNotification \
  --without-cosProperty \
  --without-cosTime \
  --without-cosTransactions \
  --without-et \
  --without-gs \
  --without-ic \
  --without-megaco \
  --without-orber \
  --without-percept \
  --without-typer \
  --with-ssl \
  --enable-threads \
  --enable-dirty-schedulers \
  --disable-hipe
RUN make -j$(getconf _NPROCESSORS_ONLN)
RUN make install
RUN find /usr/local -regex '/usr/local/lib/erlang/\(lib/\|erts-\).*/\(man\|doc\|obj\|c_src\|emacs\|info\|examples\)' | xargs rm -rf
RUN find /usr/local -name src | xargs -r find | grep -v '\.hrl$' | xargs rm -v || true
RUN find /usr/local -name src | xargs -r find | xargs rmdir -vp || true
RUN scanelf --nobanner -E ET_EXEC -BF '%F' --recursive /usr/local | xargs -r strip --strip-all
RUN scanelf --nobanner -E ET_DYN -BF '%F' --recursive /usr/local | xargs -r strip --strip-unneeded

FROM fedora:${OS_VERSION} AS final

ARG ERLANG

RUN dnf -y update \
  && dnf -y install \
    ncurses \
    $(if [ "${ERLANG:0:1}" = "1" ]; then echo "compat-openssl10"; else echo "openssl-devel"; fi) \
    unixODBC \
    lksctp-tools \
    ca-certificates \
  && dnf -y clean all && rm -rf /var/cache/yum

COPY --from=build /usr/local /usr/local
ENV LANG=C.UTF-8
