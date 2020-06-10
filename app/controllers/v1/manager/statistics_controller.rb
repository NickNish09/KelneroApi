module V1
  module Manager
    class StatisticsController < ManagerController
      def icons_stats
        render json: [
          {
              title: "total orders",
              icon: "iconsminds-basket-coins",
              value: Order.total_orders
          },
        ]
      end

      def top_selling_items
        @items = Item.top_selling_items

        render json: @items
      end
    end
  end
end
