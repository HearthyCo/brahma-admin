React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'
FieldDefs = require '../config/fieldDef'

ReactIntl = Components.mixins.ReactIntl

ToggleEditForm = React.createFactory Components.components.common.toggleEditForm
ToggleInput = React.createFactory Components.components.common.form.toggleInput
ToggleSelect = React.createFactory Components.components.common.form.toggleSelect
ToggleBoolean = React.createFactory Components.components.common.form.toggleBoolean
TogglePassword = React.createFactory Components.components.common.form.togglePassword
ToggleTextarea =
  React.createFactory Components.components.common.form.toggleTextarea

{ div, a, form } = React.DOM

module.exports = React.createClass

  displayName: 'crud-create'

  mixins: [ReactIntl]

  propTypes:
    type: FieldDefs.validator

  handleSave: (data) ->
    FieldDefs(@props.type).self.actions.create data

  render: ->
    fieldDef = FieldDefs(@props.type)

    # Quick ToggleEditForm creator
    tef = (title, childs...) =>
      params =
        title: title
        defaults: {}
        submitCallback: @handleSave
      childs.unshift params
      ToggleEditForm.apply @, childs

    keys = fieldDef.getInitialFields()
    console.log 'Initial keys:', keys

    div className: 'page-crud-edit',
      tef @props.type,
        keys.map (field, i) ->
          # Defaults for this field
          def = fieldDef.getField field
          # Defaults for properties
          props = def.props

          switch def.input
            when 'line'
              ToggleInput props
            when 'text'
              ToggleTextarea props
            when 'select'
              ToggleSelect props
            when 'boolean'
              ToggleBoolean props
            when 'password'
              TogglePassword props
