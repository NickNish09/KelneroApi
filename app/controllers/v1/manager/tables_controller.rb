module V1
  module Manager
    class TablesController < ManagerController
      before_action :set_table, only: [:show, :update, :destroy]

      # GET /v1/manager/tables
      def index
        @tables = Table.all.order(number: :asc)

        render json: @tables
      end

      # GET /v1/manager/tables/1
      def show
        render json: @table
      end

      # POST /v1/manager/tables
      def create
        @table = Table.new(table_params)

        if @table.save
          render json: @table, status: :created, location: [:v1, :manager, @table]
        else
          render json: @table.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/tables/1
      def update
        if @table.update(table_params)
          render json: @table
        else
          render json: @table.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/tables/1
      def destroy
        @table.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_table
        @table = Table.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def table_params
        params.require(:table).permit(:number, :rotation, :x_position, :y_position, :width, :height, :fill)
      end
    end

  end
end