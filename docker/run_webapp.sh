#!/bin/bash

# Prepares then runs the webapp.

# Waiting for postgresql.
echo ">>> Waiting for postgresql"
./wait-for-it.sh postgresql:5432

echo ">>> Setting up the db for Django"
python manage.py migrate

echo ">>> Starting server"
gunicorn --bind=0.0.0.0 --timeout 300 --graceful-timeout 200  pontoon.wsgi:application
