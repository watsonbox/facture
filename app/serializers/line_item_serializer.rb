class LineItemSerializer < ApplicationSerializer
  attributes :id, :description, :price, :quantity
  has_one :invoice
end