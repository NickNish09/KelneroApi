module V1
  module Waiters
    class BillsController < WaiterController
      def close_bill
        @table = Table.find params[:table_id]
        if @table.current_bill
          @table.current_bill.close_bill
        end

        render json: TableSerializer.new(@table, {
            fields: { table: %i(id number x y width height rotation fill table_name bill) }
        }).serializable_hash.to_json
      end
    end
  end
end