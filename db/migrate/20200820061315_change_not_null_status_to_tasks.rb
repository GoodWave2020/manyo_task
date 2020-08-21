class ChangeNotNullStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :status, false, '完了'
  end
end
