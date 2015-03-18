React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

{ div } = React.DOM

CrudTable = React.createFactory Components.components.common.crud.table
CrudActions = Components.actions.admin.CrudActions
EntityStores = Components.stores.EntityStores

items = [
  {id: 1, email: 'dr.riviera@gmail.mx', name: 'Dr. Riviera'}
  {id: 2, email: 'dr.zivago@gmail.mx', name: 'Dr. Zivago'}
]

module.exports = React.createClass

  displayName: 'crud'

  mixins: [ReactIntl]

  getInitialState: ->
    @updateState()

  componentDidMount: ->
    EntityStores.User.addChangeListener @updateState

  componentWillUnmount: ->
    EntityStores.User.removeChangeListener @updateState

  updateState: (props) ->
    # state = item: EntityStores.User.get(props.id)
    # @setState state
    # state

  render: ->
    div className: 'page-crud',
      CrudTable items: items, type: @props.type
