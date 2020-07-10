module V1
  module Waiters
    class TablesController < WaiterController
      def index
        @tables = Table.all.order(number: :asc)

        render json: TableSerializer.new(@tables, {
            fields: { table: %i(id number x y width height rotation fill table_name bill) }
        }).serializable_hash.to_json
      end

      def show
        @table = Table.find params[:id]

        render json: @table
      end
    end
  end
end
