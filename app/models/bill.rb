class Bill < ApplicationRecord
  belongs_to :table, optional: true
  belongs_to :user, optional: true

  has_many :bill_items
  has_many :items, through: :bill_items

  validates :final_bill, presence: true

  def as_json(options = {})
    {
      id: id,
      final_bill: final_bill,
      table: table,
      user: user,
      bill_items: bill_items,
    }
  end
end
