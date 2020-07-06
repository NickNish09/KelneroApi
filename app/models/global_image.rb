class GlobalImage < ApplicationRecord
  has_one_attached :image

  def record
    klass = Object.const_get self.model
    Apartment::Tenant.switch(self.subdomain) do
      klass.find self.model_id
    end
  end
end
