class AddRedmineProjectIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :redmine_project_id, :integer
  end
end
