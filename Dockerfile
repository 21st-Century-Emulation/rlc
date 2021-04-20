FROM golang:1.16.2 AS builder
WORKDIR /usr/local/go/src/rlc
COPY go.mod ./
RUN go mod download
COPY main.go ./
RUN CGO_ENABLED=0 go build -ldflags '-extldflags "-static"' -o /rlc .
RUN chmod +x /rlc

FROM scratch
COPY --from=builder /rlc .
ENTRYPOINT ["/rlc"]