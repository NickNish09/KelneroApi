class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :main, default: false

      t.timestamps
    end
  end
end
