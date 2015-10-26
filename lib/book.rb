class Book < ActiveRecord::Base
  validates_presence_of :title, :author

  belongs_to :user
  has_many :checked_out_books

end
