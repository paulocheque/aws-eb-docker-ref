# https://hub.docker.com/_/python/
FROM python:3.6-alpine3.6

# Copy all except files defined in the `.dockerignore`
COPY . /app
WORKDIR /app
RUN mkdir -p logs

RUN apk --update add --virtual build-dependencies gcc musl-dev linux-headers \
    # Python packages
    && python3.6 -m venv env \
    && env/bin/pip --no-cache-dir install --upgrade pip \
    && env/bin/pip --no-cache-dir install --upgrade wheel \
    # Environment Information
    && env/bin/python --version \
    && env/bin/pip --version \
    && env/bin/wheel version \
    && env \
    # Build
    && env/bin/pip --no-cache-dir install -r requirements.txt \
    # clean up
    && apk del build-dependencies \
    && rm -rf /tmp/* \
    && ls -la /app

EXPOSE 8000

CMD [ "env/bin/gunicorn", "app:myapp", "-b", "0.0.0.0:8000", "--worker-class=meinheld.gmeinheld.MeinheldWorker", "-t", "90", "-w", "3", "--log-level", "info", "--log-file", "/app/logs/gunicorn.log", "--error-logfile", "/app/logs/gunicorn-error.log", "--access-logfile", "/app/logs/gunicorn-access.log" ]
