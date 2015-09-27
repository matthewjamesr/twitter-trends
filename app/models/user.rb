class User < ActiveRecord::Base
  has_many :searches

  #validates_format_of :email, :with => /@/
  #validates :first_name, length: { minimum: 3, message: "A name must be more than three letters" }
  #validates :last_name, length: { minimum: 3, message: "A name must be more than three letters" }

  def self.find_or_create_from_auth_hash(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.avatar = auth_hash['info']['image']
    user.access_token = auth_hash['credentials']['token']
    user.twitter_secret = auth_hash['credentials']['secret']
    user.provider = auth_hash['provider']
    user.uid = auth_hash['uid']
    user.save!
    user
  end
end
