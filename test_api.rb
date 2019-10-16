require './lib/errors'
require './lib/validators'
require './lib/array_helpers'

include Errors
include Validators
include ArrayHelpers

FIRST_PART_TITLE  = "Part1"
SECOND_PART_TITLE = "Part2"
RESPONSE_TITLE      = "Result"

not_found { status_404 }

def computed_response
  arr1 = extract_array(@post_data["data"], FIRST_PART_TITLE)
  arr2 = extract_array(@post_data["data"], SECOND_PART_TITLE)

  result_array = subtract_values(arr1, arr2)

  {
    "request_id" => @request_id,
    "timestamp" => @post_data["timestamp"],
    "result": { "title": RESPONSE_TITLE, "values": result_array },
  }.to_json
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

