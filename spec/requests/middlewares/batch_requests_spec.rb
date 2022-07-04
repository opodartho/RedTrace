require 'rails_helper'

RSpec.describe BatchRequests do
    app = Rails.application
    subject { BatchRequests.new(app) }

    it "allowed if requests are present" do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)
    
        locations = create_list(:location, 3, user:, company: user.company)
    
        env = Rack::MockRequest.env_for("#{root_url(subdomain: user.company.subdomain)}batch", :method => 'POST', :params => 'requests=[{ "method": "GET", "url": "'+api_v1_locations_path+'" }]' )
        env["HTTP_AUTHORIZATION"] = "Bearer #{token.token}"
        
        status, _headers, _response = subject.call(env)
        expect(status).to eq(200)
    end

    it "not allowed if requests are invalid" do
        user = create(:user)
        application = create(:application, company_id: user.company_id)
        token = create(:token, application:, company_id: user.company_id, resource_owner_id: user.id)
    
        locations = create_list(:location, 3, user:, company: user.company)
    
        env = Rack::MockRequest.env_for("#{root_url(subdomain: user.company.subdomain)}batch", :method => 'POST', :params => 'requests=[{ "url": "'+api_v1_locations_path+'" }]' )
        env["HTTP_AUTHORIZATION"] = "Bearer #{token.token}"
        
        status, _headers, _response = subject.call(env)
        expect(status).to eq(200)
    end

    it "not allowed if requests are not present" do
        env = Rack::MockRequest.env_for("/batch", :method => 'POST' )
        status, _headers, _response = subject.call(env)
        expect(status).to eq(400)
    end
end