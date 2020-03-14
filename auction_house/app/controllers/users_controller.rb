class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
          redirect '/auctions'
        else
          erb :'users/signup'
        end
    end
      
      post'/signup' do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save && @user.username != "" && @user.email != "" && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/auctions'
        else
            redirect '/signup'
        end
      end
      
      get '/login' do
        if logged_in?
          redirect '/auctions'
        else
          erb :'users/login'
        end
      end
      
      post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/auctions'
        else
          redirect '/login'
        end
      end
      
      get '/logout' do
        if logged_in?
          session.clear
          redirect to '/login'
        else 
          redirect '/auctions'
        end
      end
      
      get '/users/:slug' do
        slug = params[:slug]
        @user = User.find_by_slug(slug)
        erb :'users/show'
      end
    
      
end