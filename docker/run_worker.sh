#!/usr/bin/env bash

# Waiting for postgresql.
echo ">>> Waiting for postgresql"
./wait-for-it.sh postgresql:5432

celery worker --app=pontoon.base.celeryapp --loglevel=info --without-gossip --without-mingle --without-heartbeat