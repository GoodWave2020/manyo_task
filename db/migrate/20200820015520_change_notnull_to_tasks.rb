class ChangeNotnullToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :dead_line, false, DateTime.now
  end
end
