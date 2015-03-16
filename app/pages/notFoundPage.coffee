React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

{ div, h1, img } = React.DOM

module.exports = React.createClass

  displayName: 'notFoundPage'

  render: ->
    div className: 'page-notFoundPage',
      h1 {}, 'WTH?!'
