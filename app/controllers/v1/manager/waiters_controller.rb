module V1
  module Manager
    class WaitersController < ManagerController
      before_action :set_waiter, only: [:show, :update, :destroy]

      # GET /v1/manager/waiters
      def index
        @waiters = Waiter.all

        render json: @waiters
      end

      # GET /v1/manager/waiters/1
      def show
        render json: @waiter
      end

      # POST /v1/manager/waiters
      def create
        @waiter = Waiter.new(waiter_params)

        if @waiter.save
          render json: @waiter, status: :created, location: [:v1, :manager, @waiter]
        else
          render json: @waiter.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/waiters/1
      def update
        if @waiter.update(waiter_params)
          render json: @waiter
        else
          render json: @waiter.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/waiters/1
      def destroy
        @waiter.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_waiter
        @waiter = Waiter.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def waiter_params
        params.require(:waiter).permit(:name)
      end
    end

  end
end