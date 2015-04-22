React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'
FieldDefs = require '../config/fieldDef'

ReactIntl = Components.mixins.ReactIntl

Rcf = React.createFactory
Common = Components.components.common

ToggleEditForm = Rcf Common.toggleEditForm
ToggleInput = Rcf Common.form.toggleInput
ToggleSelect = Rcf Common.form.toggleSelect
ToggleBoolean = Rcf Common.form.toggleBoolean
TogglePassword = Rcf Common.form.togglePassword
ToggleTextarea = Rcf Common.form.toggleTextarea

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
        keys.map (field) ->
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
