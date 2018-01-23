FROM library/python:3.6.4-alpine

WORKDIR /code/
COPY requirements.txt /code/

RUN apk --update add postgresql-client

RUN apk --update add --virtual build-dependencies \
    build-base \
    python3-dev \
    && pip3 install -U pip \
    && pip3 install -r requirements.txt \
    && apk del build-dependencies \
    && rm -f /var/cache/apk/*

ENV PYTHONPATH=/code/:$PYTHONPATH

ADD . /code/

ENTRYPOINT ["python"]
CMD ["--version"]