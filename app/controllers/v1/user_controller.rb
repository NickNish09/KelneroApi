module V1
  class UserController < ApiController
    before_action :require_user

    private

    def require_user
      unless user_signed_in?
        render json: { error: 'você precisa estar autenticado para fazer o pedido' }, status: :unauthorized
      end
    end
  end
end