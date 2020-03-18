class Bid < ActiveRecord::Base
    belongs_to :user
    belongs_to :auction
    validates_numericality_of   :bid_amount, :only_integer => true    

    def self.list_bids(user)
        user.bids
    end
end
