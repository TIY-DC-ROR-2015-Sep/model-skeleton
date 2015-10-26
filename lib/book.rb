class Book < ActiveRecord::Base
  validates_presence_of :title, :author

  def available?
    Book.find_by_id(params[:book_id]).checked_out == false
  end

end
