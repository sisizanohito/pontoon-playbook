FROM gortc:pontoon-base

# Install OS-level things
COPY set_up_ubuntu.sh /tmp/
RUN DEBIAN_FRONTEND=noninteractive /tmp/set_up_ubuntu.sh

# Create the app user
RUN useradd --shell /bin/bash -c "" -m app

# st-l10n fork.
RUN git clone https://github.com/st-l10n/pontoon.git /app
WORKDIR /app

RUN pip install -U 'pip>=8' && \
    pip install --no-cache-dir --require-hashes -r /app/requirements-dev.txt

# Install nodejs and npm from Nodesource's 8.x branch, as well as yarn
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo 'deb https://deb.nodesource.com/node_9.x jessie main' > /etc/apt/sources.list.d/nodesource.list && \
    echo 'deb-src https://deb.nodesource.com/node_9.x jessie main' >> /etc/apt/sources.list.d/nodesource.list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs yarn


# Create the folder for front-end assets
RUN mkdir -p /app/assets

# Install node requirements
RUN npm install
RUN cd frontend && yarn install

# COPY ./config/webapp.env /app/.env

# Python environment variables
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONPATH /app

# JavaScript applications paths
ENV WEBPACK_BINARY /app/node_modules/.bin/webpack
ENV YUGLIFY_BINARY /app/node_modules/.bin/yuglify

# Run webpack to compile JS files
RUN $WEBPACK_BINARY

# Build Translate.Next frontend resources
RUN cd frontend/ && yarn build

# Run collectstatic in container which puts files in the default place for
# static files.
COPY config/webapp.env .env
RUN python manage.py collectstatic --noinput
RUN rm .env

# RUN chown -R app:app /app
COPY wait-for-it.sh .
COPY run_webapp.sh .
COPY run_worker.sh .

CMD ["/app/run_webapp.sh"]
