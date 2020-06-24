module V1
  class WaiterController < ApiController
    before_action :check_permission

    private

    def current_waiter
      Waiter.find_by(token: request.headers['Authorization'])
    end

    def check_permission
      @restaurant = Restaurant.find_by(subdomain: request.headers["Subdomain"])
      unless @restaurant.waiters.include?(current_waiter)
        render json: { error: 'Apenas garçons do restaurante tem acesso à isso' }, status: :unauthorized
      end
    end
  end
end