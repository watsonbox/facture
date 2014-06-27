class LineItem < ActiveRecord::Base
  validates :description, presence: true, length: { maximum: 255 }
  validates :quantity, :price, presence: true

  belongs_to :invoice

  include Payday::LineItemable

  # TODO: Make these optional in Payday
  def display_price; nil end

  def display_quantity
    quantity.presence || '-'
  end
end
