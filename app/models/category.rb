class Category < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :items, through: :item_categories

  validates :name, presence: true, uniqueness: true

  def as_json(options = {})
    {
      id: id,
      main: main,
      name: name,
    }
  end
end
