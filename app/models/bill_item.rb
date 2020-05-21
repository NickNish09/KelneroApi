class BillItem < ApplicationRecord
  belongs_to :item
  belongs_to :bill

  def as_json(options = {})
    {
        id: id,
        item: item,
        quantity: quantity
    }
  end
end
