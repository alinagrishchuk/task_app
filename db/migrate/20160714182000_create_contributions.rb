class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions, :id => false do |t|
      t.references :user, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
    end
  end
end
