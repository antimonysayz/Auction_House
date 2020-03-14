class AuctionsController < ApplicationController

    get '/auctions' do
        erb :'auctions/show'
    end
    

end
