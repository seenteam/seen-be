class CreateFluxFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :flux_followers do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :flux_friend

      t.timestamps
    end
  end
end
