React = require 'react'
_ = require 'underscore'

console.log "React version: %s", React.version

window.brahma = dispatcher: {}, stores: {}, actions: {}

Backbone = require 'exoskeleton'
Backbone.ajax = require 'backbone.nativeajax'

Components = require 'brahma-components'
ReactIntl = Components.mixins.ReactIntl
AppDispatcher = Components.dispatcher.AppDispatcher
PageActions = Components.actions.PageActions
ModalActions = Components.actions.ModalActions

# To remove global window vars and avoid "not found require module" error, I
# created ../util/Config.coffee in components (Components.util.config) that
# returns {}. Here I extend it with real configuration
Config = require './config/config'
_.extend Components.util.config, Config

# --- CORS OVERRIDE ---
nativeajax = Backbone.ajax
Backbone.ajax = ->
  beforeSend = (xhr) ->
    xhr.withCredentials = true
  arguments[0] = _.extend arguments[0], beforeSend: beforeSend
  nativeajax.apply nativeajax, arguments

# --- /CORS ---

Components.stores.IntlStore.messages =
  'es-ES': require './locales/es-ES.json'

prepareForChange = (page, opts) -> (values...) ->
  # Yes, we can
  opts = {} if not opts?
  keys = if opts.keys? then opts.keys else []
  _.extend(opts, _.object ([key, values[i]] for key, i in keys))
  PageActions.change page, _.omit(opts, 'keys')

Router = Backbone.Router.extend
  routes:
    '': 'index'
    'login': 'login'
    'crud/:type': 'crud'
    'crud/:type/new': 'create'
    'crud/:type/:id': 'edit'
    '*notFound': 'notFound'

  index: prepareForChange require './pages/homePage'
  login: prepareForChange require './pages/loginPage'
  crud: prepareForChange (require './pages/crudPage'), keys: [ 'type' ]
  create: prepareForChange (require './pages/createPage'), keys: [ 'type' ]
  edit: prepareForChange (require './pages/editPage'), keys: [ 'type', 'id' ]
  notFound: prepareForChange require './pages/notFoundPage'

# -- Link override to use router instead --
click = (e) ->
  target = e.target
  while target and target.tagName isnt 'A' and target.tagName isnt 'BODY'
    target = target.parentNode
  if target and target.tagName is 'A'
    if not target.target and target.host is window.location.host
      PageActions.navigate target.pathname
      e.preventDefault()

document.addEventListener 'click', click, false

# -- Start it up! --
React.render React.createElement((require './pages/page'), {}), document.body
window.router = new Router()
Backbone.history.start pushState: true # Change to True when on real server

Components.actions.UserActions.getMe()
