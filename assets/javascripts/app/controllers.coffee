require 'helpers'
require 'travis/ticker'

Travis.reopen
  Controller: Em.Controller.extend
    connectOutlet: ->
      view = @_super.apply(this, arguments)

      if view
        _connectedOutletViews = Travis.app.get('_connectedOutletViews')
        unless _connectedOutletViews
          _connectedOutletViews = []

        _connectedOutletViews.pushObject(view)
        Travis.app.set('_connectedOutletViews', _connectedOutletViews)

      view

  TopController: Em.Controller.extend
    userBinding: 'Travis.app.currentUser'
  ApplicationController: Em.Controller.extend()
  MainController: Em.Controller.extend()
  StatsLayoutController: Em.Controller.extend()
  ProfileLayoutController: Em.Controller.extend()

require 'controllers/accounts'
require 'controllers/builds'
require 'controllers/home'
require 'controllers/profile'
require 'controllers/repositories'
require 'controllers/repository'
require 'controllers/sidebar'
require 'controllers/stats'
