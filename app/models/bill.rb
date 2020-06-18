class Bill < ApplicationRecord
  belongs_to :table
  has_many :commands

  def is_closed?
    !self.closed_in.nil?
  end
end
