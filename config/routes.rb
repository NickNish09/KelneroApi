class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin}
    request.headers.present? && subdomains.exclude?(request.headers["Subdomain"])
  end
end

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  scope :v1 do
    mount_devise_token_auth_for 'User', at: 'auth'
  end

  namespace :v1 do
    namespace :manager do
      resources :restaurants
      get 'main_restaurant' => 'restaurants#main_restaurant'
      constraints SubdomainConstraint do
        resources :items
        get '/get_itens_by_category/:id' => 'items#get_itens_by_category'
        resources :tables
        resources :bills
        resources :orders
        resources :categories
      end
    end

    namespace :user do
      constraints SubdomainConstraint do
        resources :orders, only: [:index, :create]
        resources :menus, only: [:index]
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
