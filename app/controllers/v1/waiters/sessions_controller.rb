module V1
  module Waiters
    class SessionsController < ApiController
      def new
        @waiter = Waiter.find_by(auth_code: params[:auth_code])

        if @waiter
          render json: @waiter, status: :ok
        else
          render json: {title: 'Nenhum garçom encontrado', msg: 'Verifique o código e tente novamente'}, status: :unprocessable_entity
        end
      end

    end
  end
end