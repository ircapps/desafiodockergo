FROM golang:1.8 AS builder

RUN mkdir -p /app
WORKDIR /app

COPY main.go /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -a -installsuffix cgo -o helloworld



FROM scratch
WORKDIR /app
COPY --from=builder /app /usr/bin/
CMD ["helloworld"]