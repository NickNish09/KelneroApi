module V1
  module Waiters
    class CommandsController < WaiterController
      def create
        @command = Command.new(command_params)
        if @command.save!
          render json: @command, status: :created, location: [:v1, :manager, @command]
        else
          render json: @command.errors, status: :unprocessable_entity
        end
      end

      private

      def command_params
        params.require(:command).permit(:table_id, :user_id, :bill_id,
                                        :final_bill,
                                        orders_attributes: [:item_id, :quantity, :details])
      end
    end
  end
end