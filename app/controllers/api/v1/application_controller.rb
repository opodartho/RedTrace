module Api
  module V1
    class ApplicationController < ActionController::API
      set_current_tenant_through_filter
      before_action :set_company_as_tenant, unless: -> { %w[admin].include?(request.subdomain) }
      # equivalent of authenticate_user! on devise, but this one will check the oauth token
      before_action :doorkeeper_authorize!

      def current_company
        @current_company ||= Company.find_by!(subdomain: request.subdomain)
      rescue ActiveRecord::RecordNotFound
        redirect_to public_root_url(subdomain: nil), allow_other_host: true
      end

      private

      # helper method to access the current user from the token
      def current_user
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
      end

      def set_company_as_tenant
        set_current_tenant(current_company)
      end
    end
  end
end
