class ProjectSerializer < ApplicationSerializer
  attributes :id, :name, :code, :redmine_project_id, :currency, :links, :has_unpaid_invoices

  def has_unpaid_invoices
    object.unpaid_invoices?
  end

  def links
    {
      invoices: project_invoices_path(id)
    }
  end
end