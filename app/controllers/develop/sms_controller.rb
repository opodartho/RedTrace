module Develop
  class SmsController < ApplicationController
    # this will only be used in development mode
    def index
      @messages = SmsAdapters::Local.messages
    end

    def destroy
      SmsAdapters::Local.clear_messages(params[:id])
      redirect_to sms_url, status: :see_other, notice: 'Successfully removed sms'
    end
  end
end
