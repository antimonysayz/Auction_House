class BidsController < ApplicationController

    get '/bids' do
        if logged_in?
            @user = current_user
            @auctions = Auction.all
            @bids = Bid.find_by(:user_id => params[:user_id])
            erb :'/bids/bids_index'
        else 
            erb :'/bids/bids_index'
        end
    end

    get '/bids/:auction_id' do
        if logged_in?
            @user = current_user
            @auction = Auction.find(params[:auction_id])
            erb :'/bids/bid_on_auctions'
        else
            redirect to '/bids'
        end

    end

    post '/bids/:auction_id' do
        @user = current_user
        @auction = Auction.find(params[:auction_id])
        if logged_in?
            @bid = Bid.create(:user_id => @user.id, :auction_id => @auction.id, :bid_amount => params[:bid_amount])
            redirect "/bids/#{@bid.auction_id}"
        else
            redirect '/bids'
        end
    end

    



    
end