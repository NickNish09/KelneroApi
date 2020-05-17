module V1
  module Manager
    class ItemsController < ManagerController
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_restaurant, only: [:show, :create, :update, :destroy]

      # GET /v1/manager/restaurants/items
      def index
        @items = Item.all
        render json: @items
      end

      # GET /v1/manager/restaurants/items/1
      def show
        render json: @item
      end

      # POST /v1/manager/restaurants/items
      def create
        @item = Item.new(item_params)

        if @item.save
          render json: @item, status: :created, location: v1_manager_restaurant_item_url(@restaurant, @item)
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/restaurants/items/1
      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/restaurants/items/1
      def destroy
        @item.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end

      def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
      end

      # Only allow a trusted parameter "white list" through.
      def item_params
        params.require(:item).permit(:name, :price, :available, :quantity)
      end
    end

  end
end