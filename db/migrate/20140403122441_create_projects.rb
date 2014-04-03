class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.references :client, index: true, null: false

      t.timestamps
    end
  end
end
