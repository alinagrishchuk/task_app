class User < ActiveRecord::Base
  has_and_belongs_to_many :tasks, :join_table => :contributions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
