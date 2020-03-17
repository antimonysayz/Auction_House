require './config/environment'
require 'sinatra/flash'


class ApplicationController < Sinatra::Base
  
  configure do
    register Sinatra::Flash
    set :public_folder, 'public'
    enable :sessions
    set :views, 'app/views'
    set :session_secret, "secret_password"
  end

  get "/" do
    erb :welcome
  end
  

  helpers do

    def logged_in?
      !!current_user    
    end
 
 
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end


end
