_ = require 'underscore'
URL = require 'url'
defaults = require './defaults'

# API
api_env = process.env.BRAHMA_API_PORT or 'tcp://localhost:9000'
api = URL.parse api_env, true
api.protocol = 'http:'
api.pathname = defaults.path

# CHAT
chat_env = process.env.BRAHMA_CHAT_PORT or 'tcp://localhost:1337'
chat = URL.parse chat_env, true

config =
  api:
    url: URL.format api
  chat:
    hostname: chat.hostname
    port: chat.port

exports = module.exports = config