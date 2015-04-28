IntlPolyfill = require 'intl'
window.Intl.NumberFormat = IntlPolyfill.NumberFormat

# Global
window.brahma =
  dispatcher: {}
  stores: {}
  actions: {}
  modal: null
  router: {}
  utils: {}

# Stack
React = require 'react'
Backbone = require 'exoskeleton'
_ = require 'underscore'
Components = require 'brahma-components'

console.log "React version: %s", React.version

# Ajax for Backbone, with CORS powerpack
Backbone.ajax = Components.util.nativeAjax

# To remove global window vars and avoid "not found require module" error, I
# created ../util/Config.coffee in components (Components.util.config) that
# returns {}. Here I extend it with real configuration
Config = require './config/config'
_.extend Components.util.config, Config

# Internationalisation
Components.stores.IntlStore.messages =
  'es-ES': require './locales/es-ES.json'

# Components
ReactIntl = Components.mixins.ReactIntl
AppDispatcher = Components.dispatcher.AppDispatcher
PageActions = Components.actions.PageActions
ModalActions = Components.actions.ModalActions

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
      e.preventDefault()
      if target.rel isnt 'disabled'
        PageActions.navigate target.pathname

window.document.addEventListener 'click', click, false

# -- Start it up! --
React.render React.createElement((require './pages/page'), {}),
  window.document.body
window.brahma.router = new Router()

# Wait for getme results before showing anything.
handler = ->
  Backbone.history.start pushState: true
  # Send load complete event.
  # AppDispatcher.trigger 'page:Loaded:success', {}
Components.actions.UserActions.getMe()
.then handler
.catch handler
