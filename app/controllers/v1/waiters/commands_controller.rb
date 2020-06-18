module V1
  module Waiters
    class CommandsController < WaiterController
      def create

      end

      private

      def command_params
        params.require(:command).permit(:table_id, :user_id, :bill_id,
                                        :final_bill, orders: [])
      end
    end
  end
end