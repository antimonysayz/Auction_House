class BidsController < ApplicationController

    get '/bids' do
        if logged_in?
            @user = current_user
            @auctions = Bid.find_by(:auction_id => params[:user_id])
            @bids = Bid.find_by(:user_id => params[:user_id])
            erb :'/bids/bids_index'
        else 
            redirect to '/auctions'
        end
    end

    
    
end