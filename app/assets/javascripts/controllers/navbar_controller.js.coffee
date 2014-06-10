Facture.NavbarController = Ember.Controller.extend
  needs: 'application'
  projects: Ember.computed.alias("controllers.application.projects")