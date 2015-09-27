class User < ActiveRecord::Base
  has_many :searches

  validates_format_of :email, :with => /@/
  validates :first_name, length: { minimum: 3, message: "A name must be more than three letters" }
  validates :last_name, length: { minimum: 3, message: "A name must be more than three letters" }

  def self.find_or_create_from_auth_hash(auth_hash)
    User.where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |u|
      u.avatar = auth_hash.info.image,
      u.access_token = auth_hash.credentials.token,
      u.twitter_secret = auth_hash.credentials.secret,
      u.provider = auth_hash.provider,
      u.uid = auth_hash.uid
    end
  end
end
