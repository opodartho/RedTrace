class GenerateOtp < ApplicationService
  def initialize(params)
    super(params)
    @sent_at = params[:sent_at]
    @token = params[:token]
  end

  def call
    ROTP::HOTP.new(token).at(hop)
  end

  private

  attr_reader :sent_at, :token

  def hop
    sent_at.to_i - PICCHI_CONST
  end
end
