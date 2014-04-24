class Project < ActiveRecord::Base
  validates :name, :code, presence: true, length: { maximum: 255 }
  validates :client, presence: true

  belongs_to :client
  has_many :invoices, dependent: :destroy

  delegate :name, to: :client, prefix: true
  delegate :address, to: :client, prefix: true
end
