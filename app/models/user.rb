# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :restaurants
  has_many :bills

  def current_bill
    self.bills.last
  end

  def as_json(options = {})
    {
      id: id,
      uid: uid,
      name: name,
      nickname: nickname,
      image: image,
      email: email,
    }
  end
end
