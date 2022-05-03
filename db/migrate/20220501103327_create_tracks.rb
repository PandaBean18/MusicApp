class CreateTracks < ActiveRecord::Migration[6.1]
    def change
        create_table :tracks do |t|
            t.integer :album_id, null: false 
            t.string :title, null: false 
            t.integer :ord, null: false 
            t.boolean :bonus_track, null: false 
            t.timestamps
        end
    end
end
