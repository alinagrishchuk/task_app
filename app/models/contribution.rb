class Contribution < ActiveRecord::Base
  belongs_to :user, inverse_of: :contributions
  belongs_to :task, inverse_of: :contributions

  validates :user, presence: true
  validates :task, presence: true
end
