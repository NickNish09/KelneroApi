class CreateGlobalImages < ActiveRecord::Migration[6.0]
  def change
    create_table :global_images do |t|
      t.string :model
      t.bigint :model_id
      t.string :subdomain

      t.timestamps
    end
  end
end
