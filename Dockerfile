FROM ruby:3.0.1-alpine

ENV BUNDLER_VERSION=2.2.21

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      openssl \
      pkgconfig \
      tzdata

RUN gem install bundler -v 2.2.21

WORKDIR /app

COPY Gemfile* .

RUN bundle check || bundle install

COPY . .
