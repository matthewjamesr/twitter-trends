require "test_helper"

class ApiTest < ActiveSupport::TestCase

  def test_that_api_responds
    assert(API.makecall("Hello", 1), msg = "API did not respond")
  end

  def test_that_query_is_not_empty
    query = "Hello"
    assert_not_nil(API.makecall(query, 1), msg = "API did not recieve a query")
  end

  def test_that_api_returns_500_tweets
    @times = 0
    API.makecall("news", 500).each do |r|
      @times = @times + 1
    end
    assert_equal 500, @times, "Did not return 500 tweets"
  end

end
