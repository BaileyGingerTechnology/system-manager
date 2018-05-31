FROM python:3.4-alpine

# Install ca-certificates for ssl
RUN set -eux; \
    apk add --no-cache --virtual ca-certificates

ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt

RUN set -eux; \
    apk add --no-cache bash

CMD ["python", "web.py"]
