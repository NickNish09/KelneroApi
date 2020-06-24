module V1
  module Waiters
    class TablesController < WaiterController
      def index
        @tables = Table.all.order(number: :asc)

        render json: @tables
      end

      def show
        @table = Table.find params[:id]

        render json: @table
      end
    end
  end
end
