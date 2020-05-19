class Item < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  validates :name, presence: true
  validates :price, presence: true

  def as_json(options = {})
    {
      id: id,
      name: name,
      price: price,
      available: available,
      quantity: quantity,
      created_at: created_at,
      updated_at: updated_at,
      categories: categories,
    }
  end
end
