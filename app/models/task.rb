class Task < ActiveRecord::Base
  default_scope { order('tasks.updated_at DESC') }

  has_and_belongs_to_many :users,  :join_table => :contributions

  validates :title,:description, presence: true
  validates :title, length: { maximum: 30 }
  validates :description, length: { maximum: 50 }

  validate :has_one_user_at_least

  def has_one_user_at_least
    if  users.empty?
      errors.add(:users, "user must be present")
    end
  end
end

