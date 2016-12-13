class Goal < ActiveRecord::Base
  validates :title, :author, presence: true
  include Commentable
  belongs_to :author,
  class_name: :User,
  foreign_key: :user_id
end
