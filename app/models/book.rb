class Book < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }   
  validates :user_id, presence: true
  validates :name, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
end
