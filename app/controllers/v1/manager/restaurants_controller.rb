module V1
  module Manager
    class RestaurantsController < ApiController
      before_action :set_restaurant, only: [:show, :update, :destroy]
      before_action :check_if_owner, only: [:show, :update, :destroy]

      def main_restaurant
        render json: current_user.main_restaurant
      end

      # GET /v1/manager/restaurants
      def index
        @restaurants = current_user.restaurants

        render json: @restaurants
      end

      # GET /v1/manager/restaurants/1
      def show
        render json: @restaurant
      end

      # POST /v1/manager/restaurants
      def create
        @restaurant = current_user.restaurants.new(restaurant_params)

        if @restaurant.save
          if params[:restaurant][:logo].to_s.length != 0
            @restaurant.logo.attach(io: image_io, filename: params[:restaurant][:logo_name])
          end
          render json: @restaurant, status: :created, location: [:v1, :manager, @restaurant]
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/restaurants/1
      def update
        if @restaurant.update(restaurant_params)
          if params[:restaurant][:logo].to_s.length != 0
            @restaurant.logo.attach(io: image_io, filename: params[:restaurant][:logo_name])
          end
          render json: @restaurant
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/restaurants/1
      def destroy
        @restaurant.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_restaurant
        @restaurant = Restaurant.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def restaurant_params
        params.require(:restaurant).permit(:name, :opening_hour, :closing_hour, :is_open, :subdomain)
      end

      def image_params
        params.require(:restaurant).permit(:logo, :logo_name)
      end

      def check_if_owner
        unless @restaurant.user == current_user
          render json: { error: 'Apenas o dono do restaurante tem acesso à isso' }, status: :unauthorized
        end
      end

      def image_io
        decoded_image = Base64.decode64(params[:restaurant][:logo])
        # decoded_image = params[:item][:image]
        StringIO.new(decoded_image)
      end

    end

  end
end