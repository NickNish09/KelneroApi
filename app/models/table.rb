class Table < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  has_many :bills
  has_many :users, through: :bills
end
