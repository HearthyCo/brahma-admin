React = require 'react/addons'
ReactIntl = require 'react-intl'
_ = require 'underscore'

Components = require 'brahma-components'
CrudActions = Components.actions.admin.CrudActions
EntityStores = Components.stores.EntityStores

ToggleEditForm = React.createFactory Components.components.common.toggleEditForm
ToggleInput = React.createFactory Components.components.common.form.toggleInput
ToggleSelect = React.createFactory Components.components.common.form.toggleSelect
ToggleBoolean = React.createFactory Components.components.common.form.toggleBoolean
ToggleTextarea =
  React.createFactory Components.components.common.form.toggleTextarea

{ div, a, form, span } = React.DOM

# Converts field values to properties
fieldProps = (item, field) ->
  id: "#{item.id}-#{field}"
  name: "#{field}"
  key: "#{item.id}-#{field}"
  label: "#{field}"
  placeholder: "#{field}"

# Default input type for fields
fieldDef =
  id:
    input: 'line'
    props: ->
      disabled: 'disabled'
  meta:
    input: 'text'
  state:
    input: 'select'
    props: ->
      options: [ 'UNCONFIRMED', 'CONFIRMED', 'DELEGATED', 'BANNED', 'DELETED' ]
  gender:
    input: 'select'
    props: ->
      options: [ 'MALE', 'FEMALE', 'OTHER' ]
  confirmed:
    input: 'boolean'
  banned:
    input: 'boolean'
  locked:
    input: 'boolean'
  default:
    input: 'line'
    props: -> {}

module.exports = React.createClass

  displayName: 'crudEditPage'

  mixins: [ReactIntl]

  propTypes:
    id: React.PropTypes.string.isRequired

  getInitialState: ->
    item: EntityStores.User.get @props.id

  componentDidMount: ->
    EntityStores.User.addChangeListener @updateState
    CrudActions.read @props.id

  componentWillUnmount: ->
    EntityStores.User.removeChangeListener @updateState

  componentWillReceiveProps: (next) ->
    if @props.id isnt next.id
      @setState item: EntityStores.User.get next.id

  updateState: ->
    console.log 'UPDATE OLD STATE', @state
    @setState item: EntityStores.User.get @props.id
    console.log 'UPDATE NEW STATE', @state

  handleSave: (data) ->
    newUser = _.extend {}, @state.item, data
    CrudActions.update newUser

  render: ->
    item = @state.item
    if not item
      return div {}

    # Quick ToggleEditForm creator
    tef = (title, childs...) =>
      params =
        title: title
        defaults: item
        submitCallback: @handleSave
      childs.unshift params
      ToggleEditForm.apply @, childs

    keys = Object.keys item

    div className: 'page-crud-edit',
      tef item.id.toString(),
        keys.map (field, i) ->
          # Defaults for this field
          def   = _.defaults (fieldDef[field] or {}), fieldDef.default
          # Defaults for properties
          props = _.defaults def.props(item, field), fieldProps(item, field)

          switch def.input
            when 'line'
              ToggleInput props
            when 'text'
              ToggleTextarea props
            when 'select'
              ToggleSelect props
            when 'boolean'
              ToggleBoolean props

      div className: 'controls',
        div
          className: 'button',
          href: '#',
          onClick: ->
            if window.confirm "Do you really want to ban #{item.name}"
              CrudActions.ban item.id
          ,
          span className: 'icon icon-problem'
          span {}, 'ban'
        div
          className: 'button',
          href: '#',
          onClick: ->
            if window.confirm "Do you really want to delete #{item.name}"
              CrudActions.delete item.id
          ,
          span className: 'icon icon-cross'
          span {}, 'delete'
