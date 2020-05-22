class Bill < ApplicationRecord
  belongs_to :table, optional: true
  belongs_to :user, optional: true

  has_many :orders
  has_many :items, through: :orders

  validates :final_bill, presence: true

  after_save :broadcast_to_channel

  def as_json(options = {})
    {
      id: id,
      final_bill: final_bill,
      user: user,
      orders: orders,
    }
  end

  def broadcast_to_channel
    BillsChannel.broadcast_to restaurant, bill: self
  end

  def restaurant
    Restaurant.find_by(subdomain: Apartment::Tenant.current)
  end

end
