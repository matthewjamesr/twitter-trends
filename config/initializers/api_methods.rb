module API

  @api = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

  def self.makecall(query, count)
    @api.search(query, result_type: "recent").take(count).collect
  end

  def self.get_location(id)
    @api.status(id)
  end

end
