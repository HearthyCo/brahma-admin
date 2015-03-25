###
On this file you can define metadata for entity and its fields.
This tells the CRUD pages which editor to use, among other things.

For each entity, the mandatory metadata includes:
  - actions: a configured CrudActions for the entity
  - headers: the list of fields to show on the list view
  - stores.entity: the associated entity store
  - stores.list: the associated list store
These keys must exist at <entity_name>.self.

For field metadata, the search order is as follows:
  - <entity_name>.<field_name>
  - global.<field_name>
  - default

Field metadata is defined as an object that can optionally contain these keys:
  - input: Control used for edition. Can be one of: line, text, select, boolean.
  - props: Function that returns an object with the props to add to the control.
  - initial: Field required at creation time.

###

_ = require 'underscore'

Components = require 'brahma-components'
CrudActions = Components.actions.admin.CrudActions
EntityStores = Components.stores.EntityStores
ListStores = Components.stores.ListStores

fieldDefs =

  # Entities
  professional:
    # Basics
    self:
      actions: CrudActions 'user', 'users', 'professional'
      headers: ['id','login','email','name']
      stores:
        entity: EntityStores.User
        list: ListStores.UsersByType.Professional
    # Fields
    fields:
      email:
        initial: true
      password:
        initial: true
      state:
        input: 'select'
        props: ->
          options: [ 'UNCONFIRMED', 'CONFIRMED', 'DELEGATED', 'BANNED', 'DELETED' ]
      gender:
        input: 'select'
        props: ->
          options: [ 'MALE', 'FEMALE', 'OTHER' ]

  # Global fields (can be overriden at the entity level)
  global:
    id:
      props: ->
        disabled: 'disabled'
    meta:
      input: 'text'

  # Base defaults
  default:
    input: 'line'
    props: -> {}


# ----------------------------------------------------------------------------
# Instead of returning the metadata object, we better return a group of
# helpers to use that info.

# Props defaults that will get overwritten by the props function of the field
baseProps = (type, field, item) ->
  item = item || {}
  id: "#{item.id}-#{field}"
  name: "#{field}"
  key: "#{item.id}-#{field}"
  label: "#{field}"
  placeholder: "#{field}"

# Get the whole section of a type, with more specific helpers
getMetadataForType = (type) ->
  meta = fieldDefs[type]

  # Get metadata for a given field
  meta.getField = (field, item) ->
    metas = [
      {}
      meta?.fields[field] or {}
      fieldDefs.global?[field] or {}
      fieldDefs.default or {}
    ]
    ret = _.defaults.apply @, metas
    ret.props = ret.props type, field, item
    _.defaults ret.props, baseProps type, field, item
    ret

  # Get initially required fields
  meta.getInitialFields = () ->
    key for key of meta.fields when meta.fields[key].initial

  meta

# Validate that the specified react prop exists and is valid
getMetadataForType.validator = (props, propName, componentName) ->
  type = props[propName]
  return new Error 'Missing entity type' if not type
  return new Error 'Unknown entity: ' + type if not fieldDefs[type]

exports = module.exports = getMetadataForType