class Restaurant < ApplicationRecord
  belongs_to :user
  after_create :create_tenant

  validates :name, presence: true, uniqueness: true

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

end
