class AuctionsController < ApplicationController

    get '/auctions' do
        if logged_in? 
            @user = current_user
            @auctions = Auction.all
            erb :'/auctions/index'

        else 
            flash[:login] = "You need to be logged in to perform that action"
            redirect '/login'
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
            flash[:empty] = "Missing Field Value"
            redirect '/auctions'
        end
            @auction = Auction.create(:name => params[:name], :description => params[:description], :current_bid => params[:current_bid], :image_url => params[:image_url], :created_by => @user.username, :user_id => @user.id)
            redirect '/bids'
    end

    get '/auctions/:id' do
        if !logged_in?
            redirect '/login'
        end
        @user = current_user
        @bids = Bid.find_by(:user_id => params[:user_id])
        @auction = Auction.find(params[:id])
        #@created_by = User.find(@auction.user_id)
        erb :'/auctions/show'

    end

    get '/auctions/:id/edit' do
        @user = current_user
        if logged_in?
            @auction = Auction.find_by(:user_id => @user.id)
            if !@auction
                flash[:wrong_user] = "You Have No Auctions!"
                redirect '/auctions'
            else
                erb :'/auctions/edit'
            end
        else
            redirect 'login'
        end
    end

    patch '/auctions/:id' do
        auction = Auction.find(params[:id])
        user = current_user
        if logged_in? && user.id == auction.user_id
            auction.update(:name => params[:name])
            auction.update(:description => params[:description], :image_url => params[:image_url])
            redirect to "/auctions/#{params[:id]}"
        else
            redirect to "/auctions/#{params[:id]}/edit"
        end
    end

    delete '/auctions/:id' do
        auction = Auction.find_by(:id => params[:id])
        if current_user.id != auction.user_id
            redirect to "/auctions/#{params[:id]}"
        elsif auction && auction.destroy
            redirect to '/auctions' 
        end
    end
    

end

