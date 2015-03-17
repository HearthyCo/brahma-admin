React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'
Text = React.createFactory Components.components.common.form.text

{ div, form } = React.DOM

Rcf = React.createFactory


fieldCallback = ->

module.exports = React.createClass

  displayName: 'crud-edit'

  render: ->
    item = {id: @props.id, email: 'dr.riviera@gmail.mx', name: 'Dr. Riviera'}
    keys = Object.keys item

    div className: 'page-crud-edit',
      form id: item.id,
        keys.map (field, i) ->
          Text
            id: "#{item.id}-#{field}"
            key: "#{item.id}-#{field}"
            label: field
            placeholder: field
            value: item[field]
            onChange: fieldCallback
