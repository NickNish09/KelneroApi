class AddRestaurantToWaiters < ActiveRecord::Migration[6.0]
  def change
    add_reference :waiters, :restaurant, foreign_key: true
  end
end
