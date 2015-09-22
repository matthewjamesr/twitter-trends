module API

  @api = Twitter::REST::Client.new do |config|
    config.consumer_key        = "SjyXYJDN7Yn43DtJhnWTBqpoC"
    config.consumer_secret     = "pRzFXgjnjLEmnAu06m7Ppw3d71N8kvlVHIHoRth5Vsp15dE2he"
    config.access_token        = "17275242-MgwXWRpiV3QcfyheT2dH5Kz8zlo36zcvEzmhnVb8T"
    config.access_token_secret = "8KLaJqVaQYQiPJUZ7OD67uhALNbFeE1NZdCLlMP6DbiLx"
  end

  def self.makecall(query)
    @api.search(query, result_type: "recent").take(100).collect
  end

end
