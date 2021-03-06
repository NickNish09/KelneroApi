module V1
  module Manager
    class ItemsController < ManagerController
      before_action :set_item, only: [:show, :update, :destroy]

      # GET /v1/manager/restaurants/items
      def index
        @items = Item.all.order(created_at: :desc)
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
          if params[:item][:image].to_s.length != 0
            # @item.image.attach(io: image_io, filename: params[:item][:filename])
            @global_image = GlobalImage.create(subdomain: Apartment::Tenant.current, model: "Item", model_id: @item.id)
            @global_image.image.attach(io: image_io, filename: params[:item][:filename])
          end
          render json: @item, status: :created, location: v1_manager_item_url(@item)
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/restaurants/items/1
      def update
        if @item.update(item_params)
          if params[:item][:image].to_s.length != 0
            # @item.image.attach(io: image_io, filename: params[:item][:filename])
            @global_image = @item.global_image
            if @global_image
              @global_image.image.attach(io: image_io, filename: params[:item][:filename])
            else
              @global_image = GlobalImage.create(subdomain: Apartment::Tenant.current, model: "Item", model_id: @item.id)
              @global_image.image.attach(io: image_io, filename: params[:item][:filename])
            end
          end
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/restaurants/items/1
      def destroy
        if @item.destroy
          render json: {title: 'Item deletado', msg: 'Item deletado com sucesso.'}, status: 200
        else
          render json: {title: 'Falha ao deletar item', msg: 'Não foi possível deletar o item. Tente novamente.'}, status: :unauthorized
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def item_params
        params.require(:item).permit(:name, :price, :available, :description, :quantity, category_ids: [])
      end

      def image_params
        params.require(:item).permit(:image, :filename)
      end

      def image_io
        decoded_image = Base64.decode64(params[:item][:image])
        # decoded_image = params[:item][:image]
        StringIO.new(decoded_image)
      end

    end

  end
end