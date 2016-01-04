require "test_helper"

class ApiTest < ActiveSupport::TestCase

  def test_that_api_responds
    assert(API.makecall("Hello", 1), msg = "API did not respond")
  end

  def test_that_query_is_not_empty
    query = "Hello"
    assert_not_nil(API.makecall(query, 1), msg = "API did not recieve a query")
  end

end
