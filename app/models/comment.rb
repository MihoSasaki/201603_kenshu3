class Comment < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 4..200}
end
