class VerifyOtp < ApplicationService
  def initialize(params)
    # set default sent_at otherwise app code might crash, it's set to -100.days
    # of current time so it won't give false positive
    @sent_at = params[:sent_at] || (Time.now.utc - 100.days)
    @token = params[:token]
    @otp = params[:otp]
  end

  def call
    # otp is invalid after 2 minutes
    return false if sent_at + 2.minutes < Time.now.utc

    hop == ROTP::HOTP.new(token).verify(otp, hop)
  end

  private

  attr_reader :sent_at, :token, :otp

  def hop
    sent_at.to_i - PICCHI_CONST
  end
end
