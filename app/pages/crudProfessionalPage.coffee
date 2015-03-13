React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

{ div } = React.DOM

Rcf = React.createFactory

crudTable = Rcf Components.components.crud.table

professionals = [
  {id: 1, email: 'dr.riviera@gmail.mx', name: 'Dr. Riviera'}
  {id: 2, eamil: 'dr.zivago@gmail.mx', name: 'Dr. Zivago'}
]

module.exports = React.createClass

  displayName: 'homePage'
  statics:
    sectionName: 'homeSection'

  render: ->
    div className: 'page-crudProfessional',
      crudTable id: 'professionals', items: professionals
