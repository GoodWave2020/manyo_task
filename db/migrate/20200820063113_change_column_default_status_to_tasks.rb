class ChangeColumnDefaultStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :status, '未着手'
  end
end
