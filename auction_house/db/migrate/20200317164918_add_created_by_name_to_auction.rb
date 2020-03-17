class AddCreatedByNameToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :created_by, :string
  end
end
