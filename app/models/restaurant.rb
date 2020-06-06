class Restaurant < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  after_create :create_tenant

  has_one_attached :logo

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true

  def as_json(options = {})
    {
      id: id,
      name: name,
      opening_hour: opening_hour,
      closing_hour: closing_hour,
      is_open: is_open,
      subdomain: subdomain,
      logo_url: logo_url,
    }
  end

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def logo_url
    if self.logo.attached?
      rails_blob_url self.logo
    else
      "https://www.receitadevovo.com.br/gbau/sistema/receitas/img/escondidinho-de-carne-moida_25092018135200.jpg"
      # ""
    end
  end

end
