class AddEndDateToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :end_date, :date
  end
end
