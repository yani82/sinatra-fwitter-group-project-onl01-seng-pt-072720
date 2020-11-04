require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    @user = current_user if is_logged_in? 

    erb :index
  end 

  get '/signup' do 
    if is_logged_in? 
      redirect '/tweets' 
    else 
      erb :'/users/signup'
    end 
  end 

  post '/signup' do 
    user = User.new(:username => params[:username], 
    :email => params[:email], 
    :password => params[:password])
    if user.save && user.username != "" && user.email != ""
      session[:user_id] = user.id 

      redirect to "/tweets"
    else
      
      redirect '/signup'
    end 
    redirect to "/tweets"
  end 

  get '/login' do 
    if is_logged_in?
      redirect '/tweets'
    else 
      erb :'/users/login'
    end 
  end 

  post '/login' do 
    user = User.find_by(:username => params[:username])

    if user && user.autenticate(params[:password])
      session[:user_id] = user.id
    end 
    redirect '/tweets' 
  end 

  get "/users/:slug" do 
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end 

  get '/logout' do
    session.clear 

    redirect "/login" 
  end 

  post '/tweet' do 
    if !params[:content].empty?
    end 
  end

end
