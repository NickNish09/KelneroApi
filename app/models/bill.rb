class Bill < ApplicationRecord
  belongs_to :table, optional: true
  belongs_to :user, optional: true

  has_many :bill_items
  has_many :items, through: :bill_items

  validates :final_bill, presence: true

  after_save :broadcast_to_channel

  def as_json(options = {})
    {
      id: id,
      final_bill: final_bill,
      table: table,
      user: user,
      bill_items: bill_items,
    }
  end

  def broadcast_to_channel
    ActionCable.server.broadcast 'bills_channel', bill: self
  end

end
