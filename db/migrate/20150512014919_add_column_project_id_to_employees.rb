class AddColumnProjectIdToEmployees < ActiveRecord::Migration
  def change
    add_column(:employees, :project_id, :int)
  end
end
