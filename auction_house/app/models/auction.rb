require "open-uri"
class Auction < ActiveRecord::Base
    has_many :bids
    belongs_to :creator, :class_name => "User", :foreign_key =>"user_id"
    has_many :users, through: :bids


end
