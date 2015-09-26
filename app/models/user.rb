class User < ActiveRecord::Base
  validates_format_of :email, :with => /@/
  validates :first_name, length: { minimum: 3, message: "A name must be more than
    three letters" }
  validates :last_name, length: { minimum: 3, message: "A name must be more than
    three letters" }
end
