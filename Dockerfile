FROM python:3.9-alpine3.18
LABEL maintaier="ifeoluwasamson90@gmail.com"

ENV PYTHON UNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

RUN python -m venv /py  && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app && \
    mkdir -P /vol/web/static && \
    mkdir -P /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol


ENV PATH="/py/bin:$PATH"

USER app