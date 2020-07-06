class Item < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :orders, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true

  def self.top_selling_items
    self.all.sort{|a,b| b.total_orders <=> a.total_orders}.first(10)
  end

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
      formated_created_at: formated_created_at,
      formated_price: formated_price,
      total_orders: total_orders,
    }
  end

  def formated_price
    number_to_currency(price)
  end

  def image_name
    "#{name}_#{id}_image"
  end

  def formated_created_at
    created_at.strftime("%d/%m/%y")
  end

  def image_url
    if self.global_image
      if self.global_image.image.attached?
        rails_blob_url self.global_image.image
      end
      # rails_blob_path(self.image, only_path: true)
      # rails_blob_url self.image
    else
      "https://www.receitadevovo.com.br/gbau/sistema/receitas/img/escondidinho-de-carne-moida_25092018135200.jpg"
      # ""
    end
  end

  def total_orders
    total = 0
    self.orders.each do |order|
      total += order.quantity
    end

    total
  end

  def global_image
    GlobalImage.where(subdomain: Apartment::Tenant.current).where(model: "Item").find_by(model_id: self.id)
  end
end
