class ProjectSerializer < ApplicationSerializer
  attributes :id, :name, :code, :links

  def links
    {
      invoices: project_invoices_path(id)
    }
  end
end