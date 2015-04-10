React = require 'react/addons'
_ = require 'underscore'

Components = require 'brahma-components'

ReactIntl = Components.mixins.ReactIntl
ListStores = Components.stores.ListStores
EntityStores = Components.stores.EntityStores
IntlStore = Components.stores.IntlStore
PageStore = Components.stores.PageStore
ModalStore = Components.stores.ModalStore
AlertStore   = Components.stores.AlertStore

UserActions = Components.actions.UserActions
PageActions = Components.actions.PageActions
ModalActions = Components.actions.ModalActions
loginPage = require './loginPage'

# Shorter lines trick
Rcf    = React.createFactory
Common = Components.components.common

menu  = Rcf Common.adminMenu
alert = Rcf Common.alert

{ section, div } = React.DOM

module.exports = React.createClass

  displayName: 'page'

  mixins: [ReactIntl]

  childContextTypes:
    availableLocales: React.PropTypes.array.isRequired
    locale: React.PropTypes.string.isRequired
    messages: React.PropTypes.object.isRequired
    formats: React.PropTypes.object.isRequired
    user: React.PropTypes.object
    opts: React.PropTypes.object

  getInitialState: ->
    locale: IntlStore.locale
    messages: IntlStore.messages[IntlStore.locale]
    page: PageStore.getPage()

  getChildContext: ->
    availableLocales: IntlStore.availableLocales
    locale: @state.locale
    messages: @state.messages
    formats: IntlStore.formats
    user: @state.user
    opts: @state.page.opts

  componentDidMount: ->
    @updateUser()
    EntityStores.User.addChangeListener @updateUser
    IntlStore.addChangeListener @updateLocale
    ModalStore.addChangeListener @updateModal
    AlertStore.addChangeListener @updateAlert
    PageStore.addChangeListener @updatePage

  componentWillUnmount: ->
    EntityStores.User.removeChangeListener @updateUser
    IntlStore.removeChangeListener @updateLocale
    ModalStore.removeChangeListener @updateModal
    AlertStore.removeChangeListener @updateAlert
    PageStore.removeChangeListener @updatePage

  updateLocale: ->
    @setState
      locale: IntlStore.locale
      messages: IntlStore.messages[IntlStore.locale]

  updateUser: ->
    isLogin = not @state.user and EntityStores.User.currentUid
    isLogout = @state.user and not EntityStores.User.currentUid
    @setState
      user: EntityStores.User.get(EntityStores.User.currentUid)
    # Auto-navigation triggered?
    if isLogin
      if @state.page.current is loginPage
        console.log window.routerNavigate '/home'
    else if isLogout
      console.log window.routerNavigate '/'

  updateModal: ->
    @setState modal: ModalStore.getModal()

  updateAlert: ->
    @setState alerts: AlertStore.getAlerts()

  updatePage: ->
    @setState page: PageStore.getPage()

  render: ->
    return false if not @state.page.current?

    # Does it need login?
    if not EntityStores.User.currentUid
      elementFactory = loginPage
    else
      elementFactory = @state.page.current

    # Should we show a modal on top?
    currentModal = false
    if @state.modal and @state.modal.visible
      currentModal = modal
        content: @state.modal.content
        onClose: ModalActions.hide

    element = React.createElement elementFactory, @state.page.opts

    classes = 'comp-page admin'
    if element.type.displayName
      classes += ' ' + element.type.displayName
    if element.type.sectionName
      classes += ' ' + element.type.sectionName

    div className: classes,
      # alerts box
      alert @state.alerts
      # modal, if needed
      currentModal

      div id: 'container',
        menu {}
        div id: 'main',
          element
