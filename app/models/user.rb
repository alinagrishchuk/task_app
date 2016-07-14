class User < ActiveRecord::Base
  has_many :contributions
  has_many :tasks,through: :contributions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
