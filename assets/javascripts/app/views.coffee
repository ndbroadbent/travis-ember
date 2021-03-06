require 'ext/ember/namespace'

@Travis.reopen
  View: Em.View.extend
    popup: (event) ->
      $("##{event.target.name}").toggleClass('display')

@Travis.reopen
  HomeView:    Travis.View.extend(templateName: 'layouts/home')
  ProfileLayoutView: Travis.View.extend(templateName: 'layouts/profile')
  StatsLayoutView:   Travis.View.extend(templateName: 'layouts/simple')
  ApplicationView: Travis.View.extend(templateName: 'application')

require 'views/accounts'
require 'views/build'
require 'views/job'
require 'views/repo'
require 'views/profile'
require 'views/sidebar'
require 'views/stats'
require 'views/top'

