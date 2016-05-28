class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
    	t.column "rc",:integer
    	t.column "value",:integer
    	t.column "game_id",:integer
      t.timestamps null: false
    end
  end
end
