class User < ActiveRecord::Base
  has_and_belongs_to_many :tasks, :join_table => :contributions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.email_search term
    where('email like ?',"%#{term}%").
      order("similarity(email, #{ActiveRecord::Base.sanitize(term)}) DESC").limit(10)
  end
end
