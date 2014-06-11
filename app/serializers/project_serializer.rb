class ProjectSerializer < ApplicationSerializer
  attributes :id, :name, :code
  has_many :invoices
end