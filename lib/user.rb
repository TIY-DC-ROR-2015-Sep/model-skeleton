class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  has_many :books
  # has_many :books_checked_out, through: :checked_out_books, source: :books
  has_many :checked_out_books

end
