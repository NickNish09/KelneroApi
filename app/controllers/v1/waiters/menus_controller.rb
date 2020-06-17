module V1
  module Waiters
    class MenusController < WaiterController
      def index
        @menu = Item.all

        render json: @menu.to_json(only: [:name, :id, :image_url])
      end
    end
  end
end
