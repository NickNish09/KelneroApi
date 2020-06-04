class AddAttributesToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :x_position, :float, default: 0.0
    add_column :tables, :y_position, :float, default: 0.0
    add_column :tables, :width, :float, default: 100.0
    add_column :tables, :height, :float, default: 100.0
    add_column :tables, :fill, :string, default: "#a6c9ff"
    add_column :tables, :rotation, :float
  end
end
