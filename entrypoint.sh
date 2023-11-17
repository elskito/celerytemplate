#!/usr/bin/env sh

case $1 in
  "develop")
    export DJANGO_SETTINGS_MODULE=backend.settings
    echo "Running migrations ..."
    python3 manage.py migrate --noinput
    echo "Running collectstatic ..."
    python3 manage.py collectstatic --noinput
    echo "Creating admin ..."
    python3 manage.py initadmin
    python3 manage.py runserver 0.0.0.0:8000
    ;;

  "prod")
    export DJANGO_SETTINGS_MODULE=backend.settings
    echo "Running migrations ..."
    python3 manage.py migrate --noinput
    echo "Running collectstatic ..."
    python3 manage.py collectstatic --noinput
    echo "Creating admin ..."
    python3 manage.py initadmin
    gunicorn backend.wsgi:application --bind 0.0.0.0:8000
    ;;

  "worker")
    echo "Running worker..."
    celery -A backend.celery.app worker
    ;;

  "flower")
    echo "Running flower ..."
    celery -A backend.celery.app flower --url_prefix=flower --address=0.0.0.0 --port=5555
    ;;

esac
