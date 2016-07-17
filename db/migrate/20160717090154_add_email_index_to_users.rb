class AddEmailIndexToUsers < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX
        users_email_trgm_idx
      ON
        users
      USING
        gist (email gist_trgm_ops);
    }
  end

  def down
    remove_index :users, name: 'users_email_trgm_idx'
  end
end
