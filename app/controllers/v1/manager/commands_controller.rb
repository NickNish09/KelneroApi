module V1
  module Manager
    class CommandsController < ManagerController
      before_action :set_command, only: [:show, :update, :destroy]

      # GET /v1/manager/commands
      def index
        @commands = Command.current_commands

        render json: @commands
      end

      # GET /v1/manager/commands/1
      def show
        render json: @command
      end

      # POST /v1/manager/commands
      def create
        @command = Command.new(command_params)

        if @command.save
          render json: @command, status: :created, location: [:v1, :manager, @command]
        else
          render json: @command.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /v1/manager/commands/1
      def update
        if @command.update(command_params)
          render json: @command
        else
          render json: @command.errors, status: :unprocessable_entity
        end
      end

      # DELETE /v1/manager/commands/1
      def destroy
        @command.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_command
        @command = Command.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def command_params
        params.require(:command).permit(:user_id, :table_id, :final_bill)
      end
    end

  end
end