class Bid < ActiveRecord::Base
    belongs_to :user
    belongs_to :auction

    def self.list_bids(user)
        user.bids
    end
end
