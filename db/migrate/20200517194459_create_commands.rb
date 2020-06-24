class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.float :final_bill
      t.references :table, foreign_key: true
      t.references :user

      t.timestamps
    end
  end
end
