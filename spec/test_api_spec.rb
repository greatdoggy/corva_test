require File.expand_path '../spec_helper.rb', __FILE__

describe "My Sinatra Application" do
  context "valid request" do
    before do
      @params = {
        timestamp: 123123,
        data: [
          { title: "Part1", values: [1,2,3] },
          { title: "Part2", values: [2,3,4] }
        ]
      }.to_json
    end

    it "returns status 200" do
      post '/compute/test', @params
      expect(last_response).to be_ok
    end

    it "returns proper data" do
      expected_result = {
        "request_id" => "test",
        "timestamp" => 123123,
        "result" => { "title" => "Result", "values" => [-1, -1, -1]}
      }
      post '/compute/test', @params
      expect(JSON.parse(last_response.body)).to eq expected_result 
    end
  end

  context "invalid post data" do
    before do
      @params = {
        timestamp: 123123,
        data: [
          { title: "Part1", values: "WRONG" },
          { title: "WRONG", values: [2,3,4] }
        ]
      }.to_json
    end

    it "returns 400 status" do
      post '/compute/test', @params
      expect(last_response.status).to eq 400
    end

    it "returns error message" do
      error_response = {"error" => "Invalid post data"}
      post '/compute/test', @params
      expect(JSON.parse(last_response.body)).to eq error_response
    end
  end

  context "invalid url" do
    it "returns 404 status" do
      post "/compute/test/error"
      expect(last_response.status).to eq 404
    end
  end
end
