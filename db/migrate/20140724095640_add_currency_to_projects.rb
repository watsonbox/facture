class AddCurrencyToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :currency, :string
  end
end
