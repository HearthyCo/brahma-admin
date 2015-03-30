React = require 'react/addons'
ReactIntl = require 'react-intl'
_ = require 'underscore'

Components = require 'brahma-components'
FieldDefs = require '../config/fieldDef'

ToggleEditForm = React.createFactory Components.components.common.toggleEditForm
ToggleInput = React.createFactory Components.components.common.form.toggleInput
TogglePassword = React.createFactory Components.components.common.form.togglePassword
ToggleSelect = React.createFactory Components.components.common.form.toggleSelect
ToggleBoolean = React.createFactory Components.components.common.form.toggleBoolean
ToggleTextarea =
  React.createFactory Components.components.common.form.toggleTextarea

{ div, a, form, span } = React.DOM

module.exports = React.createClass

  displayName: 'crudEditPage'

  mixins: [ReactIntl]

  propTypes:
    id: React.PropTypes.string.isRequired
    type: FieldDefs.validator

  getInitialState: ->
    item: FieldDefs(@props.type).self.stores.entity.get @props.id

  componentDidMount: ->
    fieldDef = FieldDefs(@props.type)
    fieldDef.self.stores.entity.addChangeListener @updateState
    fieldDef.self.actions.read @props.id

  componentWillUnmount: ->
    FieldDefs(@props.type).self.stores.entity.removeChangeListener @updateState

  componentWillReceiveProps: (next) ->
    if @props.id isnt next.id
      @setState item: FieldDefs(@props.type).self.stores.entity.get next.id

  updateState: ->
    @setState item: FieldDefs(@props.type).self.stores.entity.get @props.id

  handleSave: (data) ->
    newUser = _.extend {}, @state.item, data
    FieldDefs(@props.type).self.actions.update newUser

  render: ->
    fieldDef = FieldDefs(@props.type)
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
          def = fieldDef.getField field, item
          # Defaults for properties
          props = def.props

          switch def.input
            when 'line'
              ToggleInput props
            when 'text'
              ToggleTextarea props
            when 'select'
              ToggleSelect props
            when 'password'
              TogglePassword props
            when 'boolean'
              ToggleBoolean props

      div className: 'controls',
        div
          className: 'button',
          href: '#',
          onClick: ->
            if window.confirm "Do you really want to ban #{item.name}"
              fieldDef.self.actions.ban item.id
          ,
          span className: 'icon icon-problem'
          span {}, 'ban'
        div
          className: 'button',
          href: '#',
          onClick: ->
            if window.confirm "Do you really want to delete #{item.name}"
              fieldDef.self.actions.delete item.id
          ,
          span className: 'icon icon-cross'
          span {}, 'delete'
