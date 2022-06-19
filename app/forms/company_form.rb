class CompanyForm
  include ActiveModel::Model

  delegate :attributes=, to: :user, prefix: true
  delegate :attributes=, to: :company, prefix: true

  attr_accessor :terms_of_service, :company, :user

  validates :terms_of_service, acceptance: true

  validate :company_is_valid
  validate :user_is_valid

  def initialize(params = {})
    @company = Company.new
    @user = User.new
    super(params)
    @terms_of_service ||= false
  end

  def submit
    return false if invalid?

    company.users << user
    company.save!

    Doorkeeper::Application.create(company_id: company.id, name: company.name, redirect_uri: '', scopes: '')
  end

  private

  def company_is_valid
    errors.merge!(company.errors) if company.invalid?
  end

  def user_is_valid
    # Skiped company presence validation for user in this case
    user.errors.delete(:company) if user.invalid?

    errors.merge!(user.errors)
  end
end
