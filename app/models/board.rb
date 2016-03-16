class Board < ActiveRecord::Base
belongs_to :user
has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { in: 4..30}
  validates :user_id, presence: true
end
