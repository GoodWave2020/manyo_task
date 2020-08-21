class AddDeadLineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :dead_line, :datetime
  end
end
