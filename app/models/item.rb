class Item < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  has_one_attached :image

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
      image_url: image_url,
    }
  end

  def just_content
    {
      id: id,
      name: name,
      price: price,
      available: available,
      quantity: quantity,
      created_at: created_at,
      updated_at: updated_at,
    }
  end

  def image_name
    "#{name}_#{id}_image"
  end

  def image_url
    if self.image.attached?
      url_for self.image
    else
      "http://images.virgula.com.br/2016/06/galaxias.jpg"
    end
  end
end
