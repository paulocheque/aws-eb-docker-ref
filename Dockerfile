# https://hub.docker.com/_/python/
FROM python:3.6-alpine3.6

EXPOSE 8000

CMD [ "python3", "-m", "http.server", "8000"]
