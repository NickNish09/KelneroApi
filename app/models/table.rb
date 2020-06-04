class Table < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  has_many :bills
  has_many :users, through: :bills

  def as_json(options = {})
    {
      id: id,
      number: number,
      bills: bills,
      users: users,
      x: x_position,
      y: y_position,
      width: width,
      height: height,
      rotation: rotation,
      fill: fill,
      table_name: table_name,
      final_bill: current_final_bill
    }
  end

  def table_name
    "Mesa #{number}"
  end

  # função que retorna o total da mesa no momento, de todas as comandas de todos que estão na mesa
  def current_final_bill
    52.90
  end
end
