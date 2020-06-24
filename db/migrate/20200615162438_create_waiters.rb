class CreateWaiters < ActiveRecord::Migration[6.0]
  def change
    create_table :waiters do |t|
      t.string :name
      t.string :auth_code
      t.string :token

      t.timestamps
    end
  end
end
