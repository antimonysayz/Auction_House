class AuctionsController < ApplicationController

    get '/auctions' do
        if logged_in?
            @auctions = Auction.all
            @user = current_user
            erb :'auctions/index'
        else redirect '/login'
        end
    end
    
    get '/auctions/new' do
        if logged_in?    
            erb :'auctions/new'
        else
            redirect to '/login'
        end
    end

    post '/auctions' do
        @user = current_user
        if params[:name].empty? || params[:description].empty? || params[:current_bid].empty?
            redirect '/auctions/new'
        end
            @auction = Auction.create(:name => params[:name], :description => params[:description], :current_bid => params[:current_bid], :image_url => params[:image_url])
            redirect '/auctions'
    end

    get '/auctions/:id' do
        if !logged_in?
            redirect '/login'
        end
        @user = current_user
        @bids = Bid.find_by(:user_id => params[:user_id])
        @auction = Auction.find(params[:id])
        erb :'/auctions/show'

    end

    get '/auctions/:id/edit' do
        if logged_in?
            @auction = Auction.find(params[:id])
            if current_user.id != @auction.user_id
                redirect '/auctions'
            else
                erb :'/auctions/edit'
            end
        else
            redirect 'login'
        end
    end

    post '/auctions/:id' do
        auction = Auction.find(params[:id])
        if logged_in? && params[:bid_amount].to_i > auction.current_bid
            auction.update(:current_bid => params[:bid_amount])
            auction.update(:total_bids => +1)
            redirect to "/auctions/#{params[:id]}"
        else
            redirect to "/auctions/#{params[:id]}"
        end
    end
    

end

