class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :set_company_as_tenant
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_company
    @current_company ||= Company.find_by!(subdomain: request.subdomain)
  rescue ActiveRecord::RecordNotFound
    redirect_to public_root_url(subdomain: nil), allow_other_host: true
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :msisdn) }
  end

  def set_company_as_tenant
    set_current_tenant(current_company)
  end
end
