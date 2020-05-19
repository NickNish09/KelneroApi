class RemoveForeignKeyFromBills < ActiveRecord::Migration[6.0]
  def change
    if foreign_key_exists?(:bills, :users)
      remove_foreign_key :bills, :users
    end
  end
end
