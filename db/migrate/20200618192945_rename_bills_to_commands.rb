class RenameBillsToCommands < ActiveRecord::Migration[6.0]
  def change
    rename_table :bills, :commands
  end
end
