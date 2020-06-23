class Order < ApplicationRecord
  enum status: %i[pendente pronto]
  belongs_to :item
  belongs_to :command

  after_create :update_final_bill
  after_update :check_command_stat

  validates :quantity, presence: true

  def self.total_orders
    total = 0
    self.all.each do |order|
      total += order.quantity
    end

    total
  end

  def as_json(options = {})
    {
      id: id,
      item: item,
      quantity: quantity,
      status: status,
    }
  end

  def broadcast_command
    BillsChannel.broadcast_to restaurant, command: self.command
  end

  def check_command_stat
    statuses = self.command.orders.pluck(:status)
    if statuses.include?("pendente")
      unless self.command.pendente?
        self.command.status = "pendente" # se a comanda não estiver pendente mas tiver pedidos pendentes, entao muda pra isso
        self.command.save
      end
    else # caso em que não tem nenhum status pendente
      if self.command.pendente?
        self.command.status = "pronto"
        self.command.save
      end
    end

    broadcast_command
  end

  def update_final_bill
    self.command.final_bill += self.item.price * self.quantity
    self.command.save
  end

  def restaurant
    Restaurant.find_by(subdomain: Apartment::Tenant.current)
  end
end
