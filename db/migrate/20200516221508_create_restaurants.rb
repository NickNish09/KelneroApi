class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :opening_hour
      t.string :closing_hour
      t.string :is_open
      t.string :subdomain

      t.timestamps
    end
  end
end
