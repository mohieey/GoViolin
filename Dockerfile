FROM gcr.io/distroless/base-debian10

WORKDIR /usr/src/app

COPY . .

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["./GoViolin"]
