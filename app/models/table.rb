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
    }
  end
end
