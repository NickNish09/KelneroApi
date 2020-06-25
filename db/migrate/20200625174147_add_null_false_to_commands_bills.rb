class AddNullFalseToCommandsBills < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:commands, :bill_id, false)
  end
end
