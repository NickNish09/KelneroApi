module V1
  module Manager
    class BillsController < ManagerController
      before_action :set_bill, only: [:show, :update, :destroy]

      # GET /v1/manager/bills
      def index
        @bills = Bill.all

        render json: @bills
      end

      # GET /v1/manager/bills/1
      def show
        render json: @bill
      end

      # POST /v1/manager/bills
      def create
        @bill = Bill.new(bill_params)

        if @bill.save
          render json: @bill, status: :created, location: [:v1, :manager, @bill]
        else
          render json: @bill.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/bills/1
      def update
        if @bill.update(bill_params)
          render json: @bill
        else
          render json: @bill.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/bills/1
      def destroy
        @bill.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_bill
        @bill = Bill.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def bill_params
        params.require(:bill).permit(:user_id, :table_id, :final_bill)
      end
    end

  end
end