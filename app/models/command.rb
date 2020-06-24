class Command < ApplicationRecord
  enum status: %i[pendente pronto entregue]
  belongs_to :table#, optional: true
  belongs_to :user, optional: true
  belongs_to :bill

  has_many :orders
  has_many :items, through: :orders
  accepts_nested_attributes_for :orders

  # validates :final_bill, presence: true

  after_save :broadcast_to_channel
  before_validation :set_bill, if: Proc.new{ |command| !command.table.nil?}

  def self.current_commands
    self.joins(:bill).where('bills.closed_in IS NULL').where('commands.created_at > ?', 6.hours.ago).order(status: :asc).order(created_at: :asc)
  end

  def as_json(options = {})
    {
      id: id,
      final_bill: final_bill,
      user: user,
      orders: orders.order(status: :asc),
      table_name: table_name,
      bill_id: bill.id,
      created_at: created_at,
      status: status,
      table_id: table_id
    }
  end

  def table_name
    self.bill.table.table_name
  end

  def table_id
    self.bill.table.id
  end

  def set_bill
    current_table_bill = table.current_bill
    if current_table_bill # se tiver uma conta ja aberta já esta ela pra comanda
      self.bill = current_table_bill
    else # senão abre a conta
      self.bill = Bill.create(table: table)
    end
  end

  def broadcast_to_channel
    BillsChannel.broadcast_to restaurant, command: self
  end

  def restaurant
    Restaurant.find_by(subdomain: Apartment::Tenant.current)
  end

end
