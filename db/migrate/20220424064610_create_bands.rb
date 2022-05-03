class CreateBands < ActiveRecord::Migration[6.1]
    def change
        create_table :bands do |t|
            t.string :name, null: false
            t.integer :user_id, null: false
            t.timestamps
        end
    end
end
