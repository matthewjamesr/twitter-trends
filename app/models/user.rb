class User < ActiveRecord::Base
  has_many :searches

  validates_format_of :email, :with => /@/
  validates :first_name, length: { minimum: 3, message: "A name must be more than three letters" }
  validates :last_name, length: { minimum: 3, message: "A name must be more than three letters" }

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      avatar: auth_hash.info.image,
      access_token: auth_hash.credentials.token,
      twitter_secret: auth_hash.credentials.secret,
      provider: auth_hash.provider,
      uid: auth_hash.uid
    )
    user
  end
end
