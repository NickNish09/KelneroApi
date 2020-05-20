class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin}
    request.subdomain.present? && subdomains.exclude?(request.subdomain)
  end
end

Rails.application.routes.draw do
  scope :v1 do
    mount_devise_token_auth_for 'User', at: 'auth'
  end

  namespace :v1 do
    namespace :manager do
      resources :restaurants
      constraints SubdomainConstraint do
        resources :items
        resources :tables
        resources :bills
        resources :categories
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
