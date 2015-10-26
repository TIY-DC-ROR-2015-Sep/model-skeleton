require 'sinatra/base'
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

  def login_required!
    unless current_user
      set_message "You must login to view this page"
      redirect to("/login")
    end
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
      session[:logged_in_user_id] = found.ids
      redirect to("/")
    else
      @error = "Invalid username or password"
      erb :login
    end
  end

  post "/checkout" do
    login_required!
    c = CheckedOutBook.new
    c.user_id = current_user.id
    c.book_id = params[:book_id].to_i
    cb = Book.find_by_id(params[:book_id])
    cb.checked_out = true
    c.save!
    cb.save!
    # if c.available?
    #   c.save!
    # else
    #   # error message
    # end
    redirect to("/")
  end

  post "/return" do
    login_required!
    c = CheckedOutBook.find_by_id(params[:book_id])
    c.delete!
    cb = Book.find_by_id(params[:book_id])
    cb.checked_out = false
    c.save!
    cb.save!
    redirect to ("/")
  end

end

Bookshelf.run!
