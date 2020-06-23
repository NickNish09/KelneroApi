class Table < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  validates :number, presence: true, uniqueness: true
  has_many :commands
  has_many :users, through: :commands
  has_many :bills

  def as_json(options = {})
    {
      id: id,
      number: number,
      users: users,
      x: x_position,
      y: y_position,
      width: width,
      height: height,
      rotation: rotation,
      fill: fill,
      table_name: table_name,
      final_bill: current_final_bill,
      final_bill_number: current_final_bill_number,
      total_bill_items: total_bill_items,
      bill: current_table_bill
    }
  end

  def table_name
    "Mesa #{number}"
  end

  def current_table_bill
    current_bill.as_json(include: {commands: {include: {orders: {include: [:item]}}, methods: [:status]}})
  end

  # função que retorna o total da mesa no momento, de todas as comandas de todos que estão na mesa
  def current_final_bill
    total = 0.0
    if  current_bill
      current_bill.commands.each do |command|
        total += command.final_bill
      end
    end

    number_to_currency(total)
  end

  # função que retorna o total da mesa no momento (float), de todas as comandas de todos que estão na mesa
  def current_final_bill_number
    total = 0.0
    if current_bill
      current_bill.commands.each do |command|
        total += command.final_bill
      end

    end

    total
  end

  # function that returns the total of all command items in the table
  def total_bill_items
    total_orders = {}
    if current_bill
      current_bill.commands.each do |command|
        command.orders.each do |order|
          total_orders[order.item.name] ||= {quantity: 0, price: 0.0}
          total_orders[order.item.name][:quantity] += order.quantity
          total_orders[order.item.name][:price] += (order.quantity * order.item.price).round(2)
        end
      end
    end

    total_orders
  end

  def current_bill
    last_bill = bills.order(created_at: :asc).last
    if last_bill # se tiver uma ultima conta aberta, verifica se já foi fechada ou não
      if last_bill.is_closed? # se tiver fechada, então não existe conta atual
        nil
      else # senão retorna a última conta, que está aberta
        last_bill
      end
    else # se não tiver, então só retorna nil
      nil
    end
  end

  def current_orders
    if current_bill
      current_bill.total_orders
    else
      []
    end

  end
end
