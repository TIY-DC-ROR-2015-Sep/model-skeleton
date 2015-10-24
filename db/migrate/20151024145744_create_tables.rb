class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
    end

    create_table :books do |t|
      t.string :title
      t.string :author
      t.boolean :checked_out
    end

    create_table :checked_out_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.datetime :created_at
    end

  end
end
