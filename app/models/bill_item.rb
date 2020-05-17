class BillItem < ApplicationRecord
  belongs_to :item
  belongs_to :bill
end
