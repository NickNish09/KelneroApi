class Command < ApplicationRecord
  belongs_to :table, optional: true
  belongs_to :user, optional: true
  belongs_to :bill

  has_many :orders
  has_many :items, through: :orders

  validates :final_bill, presence: true

  after_save :broadcast_to_channel
  before_validation :set_bill, if: Proc.new{ |command| !command.table.nil?}

  def as_json(options = {})
    {
      id: id,
      final_bill: final_bill,
      user: user,
      orders: orders.order(status: :asc),
    }
  end

  def set_bill
    current_table_bill = table.current_bill
    if current_table_bill
      self.bill = current_table_bill
    else
      self.bill = Bill.create(table: table)
    end
  end

  def broadcast_to_channel
    BillsChannel.broadcast_to restaurant, bill: self
  end

  def restaurant
    Restaurant.find_by(subdomain: Apartment::Tenant.current)
  end

end
