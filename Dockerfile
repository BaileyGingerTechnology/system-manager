FROM golang:alpine as builder

# Install Git for go get
RUN set -eux; \
    apk add --no-cache --virtual git

ENV GOPATH /go/
ENV GO_WORKDIR $GOPATH/src/github.com/baileygingertechnology/goapp/

# Set WORKDIR to go source code directory
WORKDIR $GO_WORKDIR
ADD ./goapp $GO_WORKDIR

# Fetch Golang Dependency and Build Binary
RUN go get
RUN go install


FROM python:3.4-alpine

# Install ca-certificates for ssl
RUN set -eux; \
    apk add --no-cache --virtual ca-certificates

# Copy binary from builder stage into image
COPY --from=builder /go/bin/goapp .

ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "web.py"]
