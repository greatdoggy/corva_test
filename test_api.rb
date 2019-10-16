require './lib/errors'

include Errors

ATTRIBUTES = %w(timestamp data)
FIRST_PART_TITLE = "Part1"
SECOND_PART_TITLE = "Part2"
RESULT_TITLE = "Result"

def valid_attributes
      # check basic correctnes of input hash
    ATTRIBUTES.each { |attr| return false unless @post_data.keys.include? attr }
    # check "data" attribute to contain 2 elements, as stated in task description
    data = @post_data["data"]
    return false unless data.is_a?(Array) && data.size == INPUT_OBJECTS_COUNT
    # check "data" array to contain valid data
    data.each do |h|
      next if valid_data_hash? h
      return false
    end
    # input data is valid enough to process it
    true
end

def valid_data_hash?(h)
  h["values"]&.is_a?(Array) && [FIRST_PART_TITLE, SECOND_PART_TITLE].include?(h["title"])
end

def extract_array(data, title)
  [1,2,3]
end

def subtract_balues(a, b)
  [3,2,1]
end

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

