class AddCommandToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :command, foreign_key: true
    remove_column :orders, :bill_id
  end
end
