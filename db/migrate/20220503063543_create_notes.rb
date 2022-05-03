class CreateNotes < ActiveRecord::Migration[6.1]
    def change
        create_table :notes do |t|
            t.text :note, null: false 
            t.integer :track_id, null: false 
            t.integer :user_id, null: false
            t.timestamps
        end
    end
end
