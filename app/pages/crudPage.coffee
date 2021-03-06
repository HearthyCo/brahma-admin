React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

ReactIntl = Components.mixins.ReactIntl

{ div } = React.DOM

CrudTable = React.createFactory Components.components.common.crud.table
FieldDefs = require '../config/fieldDef'

module.exports = React.createClass

  displayName: 'crudPage'

  mixins: [ReactIntl]

  propTypes:
    type: FieldDefs.validator

  getInitialState: ->
    @updateState()

  componentDidMount: ->
    fieldDef = FieldDefs(@props.type).self
    fieldDef.stores.entity.addChangeListener @updateState
    items = fieldDef.stores.list.getObjects()
    if not items or items.length is 0
      fieldDef.actions.refresh()

  componentWillUnmount: ->
    fieldDef = FieldDefs(@props.type).self
    fieldDef.stores.entity.removeChangeListener @updateState

  updateState: (props) ->
    fieldDef = FieldDefs(@props.type).self
    state = items: fieldDef.stores.list.getObjects()
    @setState state
    state

  render: ->
    fieldDef = FieldDefs(@props.type).self

    div className: 'page-crud',
      CrudTable
        items: @state.items,
        header: fieldDef.headers
        type: @props.type
