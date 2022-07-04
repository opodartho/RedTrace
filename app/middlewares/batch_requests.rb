class BatchRequests
  def initialize(app)
    @app = app
  end
  
  # curl -d 'requests=[{"method":"GET", "url":"/api/v1/locations"},{"method":"POST", "url":"/api/v1/locations", "body": {} }]' http://lvh.me:3000/batch
  def call(env)
    if env["PATH_INFO"] == "/batch"
      request = Rack::Request.new(env.deep_dup)
      if request.params.key?("requests")
        responses = JSON.parse(request[:requests]).map do |override|
          process_request(env.deep_dup, override)
        end
        [200, {"Content-Type" => "application/json"}, [{responses: responses}.to_json]]
      else
        [400, {"Content-Type" => "application/json"}, ['Invalid request']]
      end
    else     
      @app.call(env)
    end
  end
  
  def process_request(env, override)
    if override.has_key?("url") && override.has_key?("method")
      path, query = override["url"].split("?")
      env["REQUEST_METHOD"] = override["method"]
      env["PATH_INFO"] = path
      env["QUERY_STRING"] = query
      env["rack.input"] = StringIO.new(override["body"].to_s)
      status, headers, body = @app.call(env)
      body.close if body.respond_to? :close
      response_body = ''
      body.each{|bod| response_body << bod }
      {status: status, url: override["url"], method: override["method"], headers: headers, body: response_body}
    else
      {status: 400, headers: {"Content-Type" => "application/json"}, body: 'Invalid request'}
    end
  end
end