module V1
  module User
    class MenusController < UserController
      def index
        @menu = Category.all

        render json: @menu.as_json(include: {items: {only: %i[id
                                                            name
                                                            price
                                                            available
                                                            quantity
                                                            created_at
                                                            updated_at
                                                            image_url]}})
      end
    end
  end
end