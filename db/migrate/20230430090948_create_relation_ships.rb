class CreateRelationShips < ActiveRecord::Migration[6.1]
  def change
    create_table :relation_ships do |t|

      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followed, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
