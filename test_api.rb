require 'sinatra'
require 'json'
require 'rubygems'

def valid_attributes
  true
end

def computed_response
  {foo: :bar}.to_json
end

def status_400
  "bad data"
end

#POST /compute/:request_id
post "/compute/:request_id" do
  begin
    @post_data = JSON.parse request.body.read
    @request_id = params[:request_id]
    if valid_attributes
      status 200
      computed_response
    else
      status_400
    end
  end
end

