class Table < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  validates :number, presence: true, uniqueness: true
  has_many :commands
  has_many :users, through: :commands

  def as_json(options = {})
    {
      id: id,
      number: number,
      commands: commands,
      users: users,
      x: x_position,
      y: y_position,
      width: width,
      height: height,
      rotation: rotation,
      fill: fill,
      table_name: table_name,
      final_bill: current_final_bill,
      total_bill_items: total_bill_items
    }
  end

  def table_name
    "Mesa #{number}"
  end

  # função que retorna o total da mesa no momento, de todas as comandas de todos que estão na mesa
  def current_final_bill
    total = 0
    commands.each do |command|
      total += command.final_bill
    end

    number_to_currency(total)
  end

  # function that returns the total of all command items in the table
  def total_bill_items
    total_orders = []
    commands.each do |command|
      total_orders.concat(command.orders)
    end

    total_orders
  end
end
