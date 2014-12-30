Facture.NavbarController = Ember.Controller.extend
  needs: 'application'
  projects: Ember.computed.alias("controllers.application.projects")
  app_title: Facture.app_title