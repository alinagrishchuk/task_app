class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :user,:task, presence: true
end
