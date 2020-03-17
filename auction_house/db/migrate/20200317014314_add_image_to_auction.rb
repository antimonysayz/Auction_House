class AddImageToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :image_url, :string
  end
end
