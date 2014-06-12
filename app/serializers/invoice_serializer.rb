class InvoiceSerializer < ApplicationSerializer
  attributes :id, :reference, :date
  has_one :project
end