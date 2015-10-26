class CheckedOutBook < ActiveRecord::Base
belongs_to :user

def available?
  Book.find_by_id(params[:book_id]).checked_out == false
end

end
