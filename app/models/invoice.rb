class Invoice < ActiveRecord::Base
  validates :reference, presence: true, length: { maximum: 255 }
  validates :project, :currency, :date, presence: true

  belongs_to :project

  delegate :client_name, to: :project
  delegate :client_address, to: :project
end
