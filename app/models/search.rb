class Search < ActiveRecord::Base
  validates :query, presence: true
  has_many :users
end
