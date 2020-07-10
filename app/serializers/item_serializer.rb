class ItemSerializer
  include JSONAPI::Serializer

  attributes :id,
              :name,
              :price,
              :available,
              :quantity,
              :created_at,
              :updated_at,
              :categories,
              :image_url,
              :formated_created_at,
              :formated_price,
              :total_orders
end