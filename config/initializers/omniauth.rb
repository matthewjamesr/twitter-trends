Rails.application.config.middleware.use OmniAuth::Builder do

  provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"],
  {
    :secure_image_url => 'true',
    :image_size => 'original'
  }

end
