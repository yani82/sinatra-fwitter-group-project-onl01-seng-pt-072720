class UsersController < ApplicationController

    get '/signup' do 
        if is_logged_in? 
          redirect '/tweets' 
        else 
          erb :'users/create_user'
        end 
    end 

    get "/users/:slug" do 
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end 

    post '/signup' do 
        user = User.new(params)
        if user.save && user.username != "" && user.email != ""
          session[:user_id] = user.id 

        # or if params[:username].empty? || params[:email].empty? || params[:password].empty?
    
          redirect to '/signup'
        end 
        
        if @user.save 
            session[:user_id] = @user.id 
            redirect '/tweets' 
        end 
    end 

    get '/login' do 
        if logged_in?
          redirect '/tweets'
        else 
          erb :'/users/login'
        end 
    end 

    get '/logout' do
        if logged_in?
            session.clear 
    
            redirect '/login' 
        else
            redirect '/' 
        end 
    end
    
    post '/login' do 
        user = User.find_by(:username => params[:username])
        # @user? 
    
        if user && user.autenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets' 
        else 
            redirect '/login' 
        end 
      end 

end




  




  

  