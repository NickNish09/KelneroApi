module V1
  module Manager
    class CategoriesController < ManagerController
      before_action :set_category, only: [:show, :update, :destroy]

      # GET /v1/manager/categories
      def index
        @categories = Category.all

        render json: @categories, include: [:items]
      end

      # GET /v1/manager/categories/1
      def show
        render json: @category
      end

      # POST /v1/manager/categories
      def create
        @category = Category.new(category_params)

        if @category.save
          render json: @category, status: :created, location: [:v1, :manager, @category]
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/categories/1
      def update
        if @category.update(category_params)
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/categories/1
      def destroy
        @category.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
