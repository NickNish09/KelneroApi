module V1
  module Waiters
    class BillsController < WaiterController
      def close_bill
        @bill = Bill.find params[:bill_id]
        @bill.close_bill

        render json: @bill.table
      end
    end
  end
end