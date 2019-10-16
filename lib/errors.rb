module Errors
  INVALID_REQUEST_ERROR  = "Invalid post data"
  INVALID_URL_ERROR      = "Invalid url"

  def status_404
    status 404
    { "error" => INVALID_URL_ERROR }.to_json
  end

  def status_400
    status 400
    { "error" => INVALID_REQUEST_ERROR }.to_json
  end
end
