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
        resources :commands
        resources :orders
        resources :categories
        resources :waiters

        #statistics routes
        get '/top_selling_items' => 'statistics#top_selling_items'
        get '/icons_stats' => 'statistics#icons_stats'
      end
    end

    namespace :user do
      constraints SubdomainConstraint do
        resources :orders, only: [:index, :create]
        resources :menus, only: [:index]
      end
    end

    namespace :waiters do
      post '/sign_in' => 'sessions#new'
      post '/token_login' => 'sessions#token_login'
      resources :tables, only: [:index, :show]
      resources :menus, only: [:index]
      resources :commands
      get '/current_commands' => 'commands#current_commands'
      post '/close_bill' => 'bills#close_bill'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
