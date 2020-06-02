class Order < ApplicationRecord
  enum status: %i[pendente entregue]
  belongs_to :item
  belongs_to :bill

  after_create :update_final_bill

  def as_json(options = {})
    {
      id: id,
      item: item,
      quantity: quantity,
      status: status,
    }
  end

  def update_final_bill
    self.bill.final_bill += self.item.price * self.quantity
    self.bill.save
  end

  def restaurant
    Restaurant.find_by(subdomain: Apartment::Tenant.current)
  end
end
