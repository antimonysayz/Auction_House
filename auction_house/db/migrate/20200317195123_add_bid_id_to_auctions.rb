class AddBidIdToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :bid_id, :integer
  end
end
