class AddDefaultValueToFinalBill < ActiveRecord::Migration[6.0]
  # That's the more generic way to change a column
  def up
    change_column :commands, :final_bill, :float, default: 0.0
  end

  def down
    change_column :commands, :final_bill, :float, default: nil
  end
end
