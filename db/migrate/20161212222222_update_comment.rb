class UpdateComment < ActiveRecord::Migration
  def change
    add_column :comments, :body, :text
    add_column :comments, :author_id, :integer
    add_column :comments, :commentable_id, :integer
    add_column  :comments, :commentable_type, :string 
  end
end
