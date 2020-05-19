module V1
  class ManagerController < ApiController
    before_action :check_if_owner

    private

    def check_if_owner
      @restaurant = Restaurant.find_by(subdomain: request.subdomain)
      unless @restaurant.user == current_user
        render json: { error: 'Apenas o dono do restaurante tem acesso à isso' }, status: :unauthorized
      end
    end
  end
end