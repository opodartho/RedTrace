module Api
  module V1
    class CallLogsController < ApplicationController
      def index
        @logs = current_user.call_logs
        render json: { logs: @logs }
      end

      def create
        call_log = CallLog.new(call_log_params.merge(user: current_user))

        if call_log.save
          render json: { call_log: }, status: :created
        else
          render json: call_log.errors, status: :unprocessable_entity
        end
      end

      private

      # Only allow a list of trusted parameters through.
      def call_log_params
        params.require(:call_log).permit(:msisdn, :call_type, :duration, :start_time, :end_time)
      end
    end
  end
end
