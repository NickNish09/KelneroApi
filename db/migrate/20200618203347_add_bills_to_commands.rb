class AddBillsToCommands < ActiveRecord::Migration[6.0]
  def change
    add_reference :commands, :bill, foreign_key: true
  end
end
