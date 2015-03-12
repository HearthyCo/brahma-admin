brahma-admin
=============

A web client for Brahma, for the Admin user role.

## Getting started
Running grunt will generate the static files at /public. Those will have no
extra dependencies, so you can just copy them to a server and you're set.

It's important to note that this package has a dependency on brahma-components
that has to be resolved manually. It expects to be on the same folder as the
other package.

BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git
