React = require 'react/addons'
ReactIntl = require 'react-intl'
_ = require 'underscore'

Components = require 'brahma-components'

{ div } = React.DOM

CrudTable = React.createFactory Components.components.common.crud.table
CrudActions = Components.actions.admin.CrudActions
EntityStores = Components.stores.EntityStores
ListStores = Components.stores.ListStores

CrudActions.config 'user', 'users', 'professional'

module.exports = React.createClass

  displayName: 'crud'

  mixins: [ReactIntl]

  getInitialState: ->
    @updateState()

  componentDidMount: ->
    ListStores.UsersByType.Professional.addChangeListener @updateState
    items = ListStores.UsersByType.Professional.getObjects()
    if not items or items.length is 0
      CrudActions.refresh()
    else
      console.log 'No need for refresh', ListStores.UsersByType.Professional.getObjects()

  componentWillUnmount: ->
    ListStores.UsersByType.Professional.removeChangeListener @updateState

  updateState: (props) ->
    state = items: ListStores.UsersByType.Professional.getObjects()
    @setState state
    state

  render: ->
    div className: 'page-crud',
      CrudTable
        items: @state.items[0],
        header: ['id','login','email','name'],
        type: @props.type
