class CompanyForm
  include ActiveModel::Model

  attr_accessor :name, :subdomain

  validates :name, :subdomain, presence: true

  delegate :attributes=, to: :person, prefix: true

  def initialize(params = {})
    super(params)
  end

  def submit
    return false if invalid?
  end
end
