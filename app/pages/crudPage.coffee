React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

{ div } = React.DOM

Rcf = React.createFactory

crudTable = Rcf Components.components.common.crud.table

items = [
  {id: 1, email: 'dr.riviera@gmail.mx', name: 'Dr. Riviera'}
  {id: 2, email: 'dr.zivago@gmail.mx', name: 'Dr. Zivago'}
]

module.exports = React.createClass

  displayName: 'crud'

  render: ->
    div className: 'page-crud',
      crudTable items: items, type: @props.type
