React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

{ div, h1, img } = React.DOM

module.exports = React.createClass

  displayName: 'homePage'
  statics:
    sectionName: 'homeSection'

  render: ->
    div className: 'page-homePage',
      h1 {}, 'Welcome, Master!'
      img src: 'https://jvyvy.files.wordpress.com/2013/03/bofh.jpg'
