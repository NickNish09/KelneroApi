module V1
  module User
    class MenusController < UserController
      def index
        @menu = Category.all

        render json: @menu
      end
    end
  end
end