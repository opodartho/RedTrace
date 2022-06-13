module Public
  class CompaniesController < ApplicationController

    def new
      @form = CompanyForm.new
    end

    # POST /companies or /companies.json
    def create
      @form = CompanyForm.new(company_params)

      if @form.submit
        redirect_to public_root_url(subdomain: @form.subdomain), allow_other_host: true, notice: "Company was successfully created."
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
end
