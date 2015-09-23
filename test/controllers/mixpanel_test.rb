require "test_helper"

class MixPanelTest < ActiveSupport::TestCase

  def test_that_api_responds
    assert(Mixpanel.track("test", "test"), msg = "Request sent even though environment is not production.")
  end

end
