require 'sinatra'
require 'pry'

require './db/setup'
require './lib/all'

class Bookshelf < Sinatra::Base
  enable :sessions

  set :logging, true

  def current_user
    logged_in_user_id = session[:logged_in_user_id]
    @current_user ||= User.find_by_id(logged_in_user_id)
  end

  get '/' do
    erb :index
  end

  get "/login" do
    erb :login
  end

  post "/handle_login" do
    found = User.where(
      email:    params[:email],
      password: params[:password])

    if found
      session[:logged_in_user_id] = found.id
      redirect to("/")
    else
      @error = "Invalid username or password"
      erb :login
    end
  end

end

Bookshelf.run!
