# Сайт нижегородского IT-сообщества

[![Build Status](https://travis-ci.org/NNRUG/it52-rails.svg?branch=it52)](https://travis-ci.org/IT61/it61-rails)
[![Code Climate](https://codeclimate.com/github/NNRUG/it52-rails/badges/gpa.svg)](https://codeclimate.com/github/NNRUG/it52-rails)
[![Test Coverage](https://codeclimate.com/github/NNRUG/it52-rails/badges/coverage.svg)](https://codeclimate.com/github/NNRUG/it52-rails)

## Main branch

Main branch is [it52](https://github.com/NNRUG/it52-rails/tree/it52)

## Getting started

Для начала работы с проектом нужно создать конфигурационые файлы на основе шаблонов:

    cp config/database.yml.template config/database.yml
    cp config/secrets.yml.template config/secrets.yml
    cp config/application.yml.template config/application.yml

Установить бандлы, создать и мигрировать БД:

    bundle install --path vendor/bundle
    bundle exec rake db:setup

Запустить rails-сервер:

    bundle exec rails s

## Style guides

- [Ruby](https://github.com/bbatsov/ruby-style-guide)
- [Rails](https://github.com/bbatsov/rails-style-guide)
- [Formatting](https://github.com/thoughtbot/guides/tree/master/style#formatting)
- [Naming](https://github.com/thoughtbot/guides/tree/master/style#naming)
- [Testing](https://github.com/thoughtbot/guides/tree/master/style#testing)
- [CoffeeScript](https://github.com/thoughtbot/guides/tree/master/style#coffeescript)
- [Markdown](http://www.cirosantilli.com/markdown-styleguide)

## Requirements
- Ruby 2
- PostgreSQL 9.x

## Спасибо

Спасибо коллегам из Ростова — [оригинальный репозиторий на GitHub](https://github.com/vtambourine/it61-rails)
