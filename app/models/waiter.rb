class Waiter < ApplicationRecord
  belongs_to :restaurant

  before_create :set_auth_code
  before_create :set_token

  validates :name, presence: true

  def set_auth_code
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    begin
      code = SecureRandom.hex(3).upcase
      x = code[0] =~ /[[:alpha:]]/
      first_is_letter = (x == 0)
      unless first_is_letter
        code[0] = chars.sample.upcase
      end

      self.auth_code = code
    end while Waiter.where(auth_code: self.auth_code).exists?
  end

  def set_token
    self.token = Devise.friendly_token
  end
end
