module V1
  module Manager
    class OrdersController < ManagerController
      before_action :set_order, only: [:show, :update, :destroy]

      # GET /v1/manager/orders
      def index
        @orders = Order.all

        render json: @orders
      end

      # GET /v1/manager/orders/1
      def show
        render json: @order
      end

      # POST /v1/manager/orders
      def create
        @order = Order.new(order_params)

        if @order.save
          render json: @order, status: :created, location: [:v1, :manager, @order]
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/orders/1
      def update
        if @order.update(order_params)
          render json: {order: @order, bill: @order.bill}
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/orders/1
      def destroy
        if @order.destroy
          render json: {title: "Pedido deletado", msg: "Pedido deletado com sucesso."}, status: 200
        else
          render json: {title: "Falha ao deletar pedido", msg: "Não foi possível deletar o pedido. Tente novamente."}, status: :unauthorized
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = Order.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def order_params
        params.require(:order).permit(:item_id, :bill_id, :quantity, :details, :status)
      end
    end

  end
end