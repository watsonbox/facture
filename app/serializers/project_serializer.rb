class ProjectSerializer < ApplicationSerializer
  attributes :id, :name, :code, :redmine_project_id, :links

  def links
    {
      invoices: project_invoices_path(id)
    }
  end
end