class AddEmailIndexToUsers < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX
        users_email
      ON
        users (lower(email))
    }
  end

  def down
    remove_index :users, name: 'users_email'
  end
end

