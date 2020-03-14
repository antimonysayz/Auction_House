class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.integer :current_bid
      t.integer :total_bids
      t.timestamps
    end
  end
end
