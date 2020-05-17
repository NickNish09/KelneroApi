class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.float :final_bill
      t.references :table, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
