React = require 'react/addons'
ReactIntl = require 'react-intl'
_ = require 'underscore'

Components = require 'brahma-components'
Text = React.createFactory Components.components.common.form.text
CrudActions = Components.actions.admin.CrudActions
EntityStores = Components.stores.EntityStores

{ div, a, form } = React.DOM

Rcf = React.createFactory

# private method
fieldProps = (item, field) ->
  id: "#{item.id}-#{field}"
  key: "#{item.id}-#{field}"
  label: "#{field}"
  placeholder: "#{field}"
  value: item[field]
  onChange: ->

fieldDef =
  id:
    noedit: true
    input: 'line'

  meta:
    input: 'text'

  default:
    noedit: false
    input: 'line'
    props: -> {}


module.exports = React.createClass

  displayName: 'crud-edit'

  mixins: [ReactIntl]

  getInitialState: ->
    @updateState()

  componentDidMount: ->
    EntityStores.User.addChangeListener @updateState

  componentWillUnmount: ->
    EntityStores.User.removeChangeListener @updateState

  updateState: (props) ->
    props = props or @props
    console.log 'id', props.id
    state = item: EntityStores.User.get(props.id)
    @setState state
    state

  render: ->
    item = @state.item
    if not item
      return console.error 'Unkown item with Id: ', @props.id

    console.log 'State', @state
    keys = Object.keys item

    div className: 'page-crud-edit',
      form id: item.id,
        keys.map (field, i) ->
          def = _.defaults (fieldDef[field] or {}), fieldDef.default
          props = _.defaults def.props(item, field), fieldProps(item, field)

          switch def.input
            when 'line'
              Text props
            when 'text'
              Text _.extend props, { multi: true }

      div className: 'controls',
        a
          href: '#',
          onClick: ->
            console.log 'AAAAAAAAAAAAAAAAAA'
            CrudActions.create _.omit(item, 'id')
          ,
          'clone'
        a
          href: '#',
          onClick: ->
            CrudActions.ban item.id
          ,
          'ban'
        a
          href: '#',
          onClick: ->
            CrudActions.delete item.id
          ,
          'delete'

