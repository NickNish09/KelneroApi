class Bill < ApplicationRecord
  belongs_to :table, optional: true
  belongs_to :user

  has_many :bill_items
  has_many :items, through: :bill_items
end
