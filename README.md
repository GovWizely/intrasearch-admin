# intrasearch

[![Build Status](https://travis-ci.org/GovWizely/intrasearch-admin.svg?branch=master)](https://travis-ci.org/GovWizely/intrasearch-admin)
[![Code Climate](https://codeclimate.com/github/GovWizely/intrasearch-admin/badges/gpa.svg)](https://codeclimate.com/github/GovWizely/intrasearch-admin)
[![Test Coverage](https://codeclimate.com/github/GovWizely/intrasearch-admin/badges/coverage.svg)](https://codeclimate.com/github/GovWizely/intrasearch-admin/coverage)

Provides admin interface for intrasearch.

## Dependencies

- Ruby 2.2
- Bundler 1.11.2
- A running intrasearch

## Setup

- Start [intrasearch](https://github.com/GovWizely/intrasearch)
- Copy `config/devise.yml.example` to `config/devise.yml`
- Copy `config/intrasearch.yml.example` to `config/intrasearch.yml`
- Copy `config/intrasearch_admin.yml.example` to `config/intrasearch_admin.yml`
- Copy `config/secrets.yml.example` to `config/secrets.yml`
- Run `bundle`
- Add user from the console `bundle exec rails c`
  ```
    u = User.create email: 'foo@example.com'
    u.reset_password 'changemE', 'changemE'
  ```
- Start the app: `bundle exec rails s`
- Open [localhost:3000](http://localhost:3000)

Cheers!
