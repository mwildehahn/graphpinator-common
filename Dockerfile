FROM hhvm/hhvm:4.56.6

ADD . /app
WORKDIR /app

ENTRYPOINT /bin/bash