class SubdomainRequired
  def self.matches?(request)
    request.subdomain.present? && %w[www admin].exclude?(request.subdomain)
  end
end
