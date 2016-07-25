class User < ActiveRecord::Base
  has_and_belongs_to_many :tasks, :join_table => :contributions

  scope :all_except, ->(user_ids) { where.not(id: user_ids) }
  scope :simple, ->{ pluck(:id, :email).map { |user| { value: user[0], label: user[1] }}}

  def self.email_search_filtered(term, user_ids,limit)
    email_search_full(term).
        all_except(user_ids).
        limit(limit)
  end

  def self.email_search_full term
    where('email like ?',"%#{term}%").
      order("similarity(email, #{ActiveRecord::Base.sanitize(term)}) DESC")
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
