class Project < ActiveRecord::Base
  validates :name, :code, presence: true, length: { maximum: 255 }
  validates :client, presence: true

  belongs_to :client
  has_many :invoices, dependent: :destroy

  delegate :name, to: :client, prefix: true
  delegate :address, to: :client, prefix: true

  attr_writer :unpaid_invoices

  def unpaid_invoices?
    return @unpaid_invoices unless @unpaid_invoices.nil?
    invoices.where(paid: false).exists?
  end

  # Load all projects with unpaid invoice rollup data
  def self.all_with_unpaid_invoices
    projects = all.index_by(&:id)

    projects.values.each do |project|
      project.unpaid_invoices = false
    end

    Invoice.unpaid.pluck(:project_id).each do |project_id|
      projects[project_id].unpaid_invoices = true
    end

    projects.values
  end
end
