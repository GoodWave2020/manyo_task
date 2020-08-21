class ChangeNotNullPriorityToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :priority, false, 0
  end
end
