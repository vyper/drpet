# Dr Pet [![Build Status](https://travis-ci.org/vyper/drpet.svg?branch=master)](https://travis-ci.org/vyper/drpet) [![Code Climate](https://codeclimate.com/github/vyper/drpet/badges/gpa.svg)](https://codeclimate.com/github/vyper/drpet) [![Test Coverage](https://codeclimate.com/github/vyper/drpet/badges/coverage.svg)](https://codeclimate.com/github/vyper/drpet/coverage) [![Dependency Status](https://gemnasium.com/vyper/drpet.svg)](https://gemnasium.com/vyper/drpet)

My playground for [lotus](http://lotusrb.org).


## Curious?
To you see app running is very simple!

You have two options:
- Access http://drpet.herokuapp.com and you use email `drpet@mcorp.io` and password `123456`; or
- Use the API http://drpet.herokuapp.com/api/v1/pets

## TODO
- [ ] specs!
  - [x] ~~entities~~
  - [x] repositories
  - [x] ~~controllers~~
  - [ ] views
  - [x] ~~integrations~~
  - [x] ~~matchers validations~~
  - [ ] fixtures / factories
- [ ] improve layout
- [ ] add auth using google
- [ ] auth for api
- [x] ~~crud for pets~~
- [ ] crud for events
  - [ ] create
  - [ ] read
  - [ ] update
  - [ ] delete
- [ ] add instructions for clone and run
- [x] ~~create matchers for specs~~
  - [x] ~~alpha version for validations~~
  - [x] ~~port matchers validations to gem~~ > ported to [shoulda-lotus](https://github.com/mcorp/shoulda-lotus)
- [x] ~~improve auth to don't repeat `authenticate!` in all controllers~~
- [x] ~~add flash messages~~
- [x] ~~add validations on [controller params](https://github.com/lotus/controller#params)~~
- [ ] add repository on initialize of controllers
- [x] ~~improve flash messages to don't repeat 'expose :flash' in all controllers~~
- [ ] review `TODO` on source code
