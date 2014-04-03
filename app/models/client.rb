class Client < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }

  has_many :projects, dependent: :destroy
end
