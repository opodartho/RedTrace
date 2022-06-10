class CompanyForm
  include ActiveModel::Model

  attr_accessor :name, :subdomain, :owner_name, :msisdn

  validates :name, :subdomain, :owner_name, :msisdn, presence: true
  validates :subdomain, format: {
    with: /\A(^[A-Za-z0-9](?:[A-Za-z0-9\-]{0,61}[A-Za-z0-9])?$)\z/i,
    message: 'must be a valid subdomain'
  }
  validates :msisdn, format: {
    with: /\A(8801[3-9]\d{8})\z/i,
    message: 'must be a valid msisdn'
  }

  #delegate :attributes=, to: :person, prefix: true

  def initialize(params = {})
    super(params)
  end

  def submit
    return false if invalid?
    # Add transaction to create company and user
    Company.transaction do
      company = Company.create!(name: name, subdomain: subdomain)
      user = company.users.create!(name: owner_name, msisdn: msisdn)
    end
  end
end
