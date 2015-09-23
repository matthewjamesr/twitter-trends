module Mixpanel

  require 'mixpanel-ruby'

  @tracker = Mixpanel::Tracker.new("a3b7ad3a23f687e95b5c5770c3c8e29a")

  def self.track(value, name)
    if $RAILS_ENV == "production"
      @tracker.track(value, name)
    end
  end

end
