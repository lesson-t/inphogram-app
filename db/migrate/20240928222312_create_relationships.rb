class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :following, null: false, foreign: { to_table: :users}
      t.references :follower, null: false, foreign: { to_table: :users}
      t.timestamps
    end
  end
end
