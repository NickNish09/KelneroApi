class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :item, null: false, foreign_key: true
      t.references :bill, null: false, foreign_key: true
      t.integer :quantity
      t.text :details

      t.timestamps
    end
  end
end
