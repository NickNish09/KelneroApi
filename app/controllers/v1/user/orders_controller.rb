module V1
  module User
    class OrdersController < UserController
      # retorna um histórico de pedidos do usuário
      def index
        @commands = current_user.commands

        render json: @commands
      end

      # cria um pedido
      def create
        @orders = order_params # array de itens pedidos
        @items = @orders[:items]

        @created_array = current_user.current_command.orders.create(@items)
        if @created_array.map{ |order| order.persisted?}.include?(false) # ver se algum pedido não foi criado
          render json: {error: 'Um dos pedidos não pode ser criado'}, status: :unprocessable_entity
        else
          render json: current_user.current_command, status: :created
        end
      end

      private

      def order_params
        params.require(:orders).permit(items: [:item_id, :quantity, :details, :command_id])
      end

    end
  end
end