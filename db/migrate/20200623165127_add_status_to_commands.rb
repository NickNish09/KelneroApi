class AddStatusToCommands < ActiveRecord::Migration[6.0]
  def change
    add_column :commands, :status, :integer, default: 0
  end
end
