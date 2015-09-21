require "test_helper"

class ApiTest < ActiveSupport::TestCase

  def test_that_api_responds
    assert(API.request(1), msg = "API did not respond")
  end

  def test_that_api_returns_100_tweets
    @times = 0
    API.request("news").each do |r|
      @times = @times + 1
    end
    assert_equal 100, @times, "Did not return 100 tweets"
  end

end
