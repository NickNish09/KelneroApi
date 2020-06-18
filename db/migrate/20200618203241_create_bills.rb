class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.datetime :closed_in
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
