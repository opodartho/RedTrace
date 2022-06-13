class CompanyForm
  include ActiveModel::Model

  # TODO: need to change below
  # MSISDN will be submitted in 01833xxxxxx format and need to save in
  # 8801833xxxxxx format

  attr_accessor :name, :subdomain, :owner_name, :msisdn

  validates :name, :subdomain, :owner_name, :msisdn, presence: true
  validates :subdomain, format: {
    with: /\A(^[A-Za-z0-9](?:[A-Za-z0-9\-]{0,61}[A-Za-z0-9])?$)\z/i,
    message: 'must be a valid subdomain',
  }
  validates :msisdn, format: {
    with: /\A(8801[3-9]\d{8})\z/i,
    message: 'must be a valid msisdn',
  }

  # delegate :attributes=, to: :person, prefix: true

  def initialize(params = {})
    super(params)
  end

  def submit
    return false if invalid?

    # Add transaction to create company and user
    Company.transaction do
      company = Company.create!(name:, subdomain:)
      company.users.create!(name: owner_name, msisdn:)
    end
    self
  end
end
