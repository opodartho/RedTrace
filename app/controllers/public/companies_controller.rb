module Public
  class CompaniesController < ApplicationController
    def new
      @form = CompanyForm.new
    end

    # POST /companies
    def create
      @form = CompanyForm.new(company_params)

      if @form.submit
        redirect_to(
          public_root_url(subdomain: @form.company.subdomain),
          allow_other_host: true,
          notice: 'Company was successfully created.'
        )
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company_form).permit(:terms_of_service, company_attributes: [:name, :subdomain], user_attributes: [:name, :msisdn])
    end
  end
end
