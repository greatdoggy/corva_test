module Validators
  ATTRIBUTES          = %w(timestamp data)
  INPUT_OBJECTS_COUNT = 2 # count of objects in "data" attribute in params

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
end
