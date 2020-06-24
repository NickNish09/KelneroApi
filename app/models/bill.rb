class Bill < ApplicationRecord
  belongs_to :table
  has_many :commands

  def is_closed?
    !self.closed_in.nil?
  end

  def total_orders
     total = []
     commands.each do |command|
       total.concat(command.orders)
     end

     total
  end

  def close_bill
    self.closed_in = DateTime.now
    self.save
  end
end
