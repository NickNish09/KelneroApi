module V1
  module Manager
    class ItemsController < ManagerController
      before_action :set_item, only: [:show, :update, :destroy]

      # GET /v1/manager/restaurants/items
      def index
        @items = Item.all
        render json: @items
      end

      def get_itens_by_category
        @category = Category.find params[:id]

        render json: @category.items
      end

      # GET /v1/manager/restaurants/items/1
      def show
        render json: @item
      end

      # POST /v1/manager/restaurants/items
      def create
        @item = Item.new(item_params)

        if @item.save
          if params[:item][:image]
            @item.image.attach(io: image_io, filename: @item.image_name)
          end
          render json: @item, status: :created, location: v1_manager_item_url(@item)
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

      # Only allow a trusted parameter "white list" through.
      def item_params
        params.require(:item).permit(:name, :price, :available, :quantity, category_ids: [])
      end

      def image_params
        params.require(:item).permit(:image)
      end

      def image_io
        decoded_image = Base64.decode64(params[:item][:image])
        StringIO.new(decoded_image)
      end
    end

  end
end