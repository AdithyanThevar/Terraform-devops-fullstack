FROM golang:alpine3.20 as build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . . 
RUN go build main.go

FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/main .
CMD ["./main"]
