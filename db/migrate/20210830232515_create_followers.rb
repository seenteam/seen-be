class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :friend

      t.timestamps
    end
  end
end