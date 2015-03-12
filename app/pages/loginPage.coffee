React = require 'react/addons'
_ = require 'underscore'

Components = require '../../brahma_modules/brahma-components/dist/index.js'

LoginForm = React.createFactory Components.components.user.loginForm

{ div, span, a } = React.DOM

module.exports = React.createClass

  displayName: 'loginPage'
  statics:
    sectionName: 'externalSection'
    isPublic: true

  render: ->
    div className: 'page-loginPage',
      LoginForm {}
