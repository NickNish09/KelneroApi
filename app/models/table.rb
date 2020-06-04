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
    }
  end

  def table_name
    "Mesa #{number}"
  end
end
