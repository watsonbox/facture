class LineItem < ActiveRecord::Base
  validates :description, presence: true, length: { maximum: 255 }
  validates :quantity, :price, presence: true

  belongs_to :invoice
end
