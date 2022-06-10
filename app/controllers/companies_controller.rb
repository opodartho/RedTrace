class CompaniesController < ApplicationController
  skip_before_action :authenticate_user!

  # GET /companies or /companies.json
  def index
    @companies = Company.all
  end

  def new
    @form = CompanyForm.new
  end

  # POST /companies or /companies.json
  def create
    @form = CompanyForm.new(company_params)

    if @form.submit
      redirect_to companies_url, notice: "Company was successfully created."
    else
      render :new, status: :unprocessable_entity  
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company_form).permit(:name, :subdomain, :owner_name, :msisdn)
  end
end
