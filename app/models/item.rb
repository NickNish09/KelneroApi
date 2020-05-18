class Item < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  validates :name, presence: true
  validates :price, presence: true
end
