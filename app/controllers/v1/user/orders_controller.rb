module V1
  module User
    class OrdersController < UserController
      # retorna um histórico de pedidos do usuário
      def index
        @bills = current_user.bills

        render json: @bills
      end

      # cria um pedido
      def create
        @orders = order_params # array de itens pedidos
        @items = @orders[:items]
        current_user.current_bill.orders.create(@items)

        render json: {msg: "criado"}
      end

      private

      def order_params
        params.require(:orders).permit(items: [:item_id, :quantity, :details, :bill_id])
      end

    end
  end
end