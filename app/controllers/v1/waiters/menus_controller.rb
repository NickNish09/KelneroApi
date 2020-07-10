module V1
  module Waiters
    class MenusController < WaiterController
      def index
        @menu = Item.all

        # render json: @menu.to_json(only: [:name, :id, :image_url])
        render json: ItemSerializer.new(@menu, fields: {
            item: %i(id name image_url available price)
        })
      end
    end
  end
end
