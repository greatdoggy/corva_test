module ArrayHelpers
  def extract_array(data, title)
    data.select{ |el| el["title"] == title }.first["values"]
  end

  def subtract_values(a, b)
    a.each_with_index.map do |num, i|
      b[i].nil? ? num : num - b[i] # to cover that case when first array is larger than second
    end
  end
end
