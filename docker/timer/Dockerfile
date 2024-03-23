FROM alpine

RUN apk --no-cache add curl

WORKDIR /app
COPY entrypoint.sh .

CMD ["./entrypoint.sh"]
