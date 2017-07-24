# https://hub.docker.com/_/python/
FROM python:2.7-alpine3.6

# Copy all except files defined in the `.dockerignore`
COPY . /app
WORKDIR /app
RUN mkdir -p logs

RUN apk --update add --virtual build-dependencies gcc musl-dev linux-headers \
    && apk --update add nginx \
    # Python packages
    && pip --no-cache-dir install virtualenv \
    && virtualenv env -p python2.7 \
    && env/bin/pip --no-cache-dir install --upgrade pip \
    && env/bin/pip --no-cache-dir install --upgrade wheel \
    # Environment Information
    && env/bin/python --version \
    && env/bin/pip --version \
    && env/bin/wheel version \
    && nginx -v \
    && which nginx \
    && env \
    # Build
    && env/bin/pip --no-cache-dir install -r requirements.txt \
    # clean up
    && apk del build-dependencies \
    && rm -rf /tmp/* \
    && ls -la /app

# Testing the nginx.conf file
RUN nginx -t -p . -c nginx.conf

# Nginx
EXPOSE 8000

CMD [ "env/bin/supervisord", "-c", "supervisord.conf"]
