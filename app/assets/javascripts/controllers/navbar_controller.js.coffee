Facture.NavbarController = Ember.Controller.extend
  needs: 'application'
  projects: Ember.computed.alias("controllers.application.projects")
  sortProperties: ['name:asc'],
  sortedProjects: Ember.computed.sort('projects', 'sortProperties')
  app_title: Facture.app_title