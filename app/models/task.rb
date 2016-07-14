class Task < ActiveRecord::Base
  default_scope { order('tasks.updated_at DESC') }

  has_many :contributions, dependent: :destroy
  has_many :users, through: :contributions

  validates :title,:description, presence: true
  validates :title, length: { maximum: 30 }
  validates :description, length: { maximum: 50 }
  validates :users, presence: true
end
