require 'bundler'
Bundler.require

set :database, 'sqlite:///database.db'

class User < ActiveRecord::Base
  validates :twitter_user_id, uniqueness: true
end
