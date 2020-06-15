module V1
  module Manager
    class WaitersController < ManagerController
      before_action :set_waiter, only: [:show, :update, :destroy]
      before_action :set_current_restaurant

      # GET /v1/manager/waiters
      def index
        @waiters = @restaurant.waiters

        render json: @waiters
      end

      # GET /v1/manager/waiters/1
      def show
        render json: @waiter
      end

      # POST /v1/manager/waiters
      def create
        @waiter = @restaurant.waiters.new(waiter_params)

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

      def set_current_restaurant
        @restaurant = Restaurant.find_by(subdomain: request.headers["Subdomain"])
      end
    end

  end
end